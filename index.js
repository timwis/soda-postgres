var parser = require('../node-soda2-parser'),
	restify = require('restify'),
	anyDB = require('any-db-postgres');
require('dotenv').load();
var inspect = function(data) { console.log(require('util').inspect(data, false, 10, true)); };

var conn = anyDB.createConnection(process.env.DATABASE_URL);
	
var server = restify.createServer();
server.use(restify.queryParser());

server.get('/resource/:table', function(req, res, next) {	
	// Get table structure
	getFields(req.params.table, function(err, result) {
		if(err) return console.error(err);
		
		// Map [{name: 'foo', type: 'int'}] to {foo: 'int'} for faster lookup
		var fields = {}, fieldsArr = [];
		result.rows.forEach(function(row) {
			fields[row.name] = row.type;
			fieldsArr.push(row.name);
		});
		
		// If SELECT is *, replace with fieldStr
		if(req.query.$select === undefined || ! req.query.$select || req.query.$select === '*') {
			req.query.$select = fieldsArr.join(', ');
		}
		
		// Parse query into AST
		var ast = parser.parse(req.query);
		inspect(ast);
		
		// Add FROM table to AST
		ast.from = [{table: req.params.table}];
		
		// Wrap any SELECTs of geometry type columns in ST_AsGeoJSON()
		ast.columns.forEach(function(col) {
			console.log('col', col);
			if(col.expr.type === 'column_ref' && fields[col.expr.column] === 'geometry') {
				var fieldName = col.expr.column;
				col.expr = {type: 'aggr_func', name: 'ST_AsGeoJSON', args: { expr: col.expr } };
				if(col.as === undefined || ! col.as) col.as = fieldName;
			}
		});
		
		// Convert AST back to SQL
		var sql = parser.stringify.parse(ast);
		
		// Cast any GeoJSON references to json
		sql = sql.replace(/ST_AsGeoJSON\((.+?)\)/g, 'ST_AsGeoJSON($1)::json'); 
				
		// Query database
		console.log(req.query, sql);
		conn.query(sql, function(err, result) {
			if(err) console.error(err);
			res.json(result.rows);
			next();
		});
	});
});

server.listen(8080, function() {
	console.log('%s listening at %s', server.name, server.url);
});


/**
 * Get table fields
 */
var getFields = function(table, cb) {
	var sql = 'select column_name AS name, udt_name AS type from INFORMATION_SCHEMA.COLUMNS where table_name = \'' + table + '\';';
	conn.query(sql, cb);
};
