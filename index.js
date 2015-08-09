var parser = require('node-soda2-parser'),
	restify = require('restify'),
	_ = require('underscore'),
	anyDB = require('any-db-postgres'),
	processWhere = require('./lib/where'),
	processSelect = require('./lib/select');
require('dotenv').load();

var server_port = process.env.OPENSHIFT_NODEJS_PORT || 8080,
	server_ip_address = process.env.OPENSHIFT_NODEJS_IP || '127.0.0.1', 
	conn = anyDB.createConnection(process.env.DATABASE_URL),
	tables = {},
	server = restify.createServer();
server.use(restify.queryParser());

server.get('/resource/:table', function(req, res, next) {
	// If table doesn't exist, send error
	if(tables[req.params.table] === undefined) {
		return res.send(404);
	}
	
	// Parse query into AST
	var ast = parser.parse(req.query);
	
	// Process SELECT columns
	ast.columns = processSelect(ast.columns, tables[req.params.table]);
	
	// Add FROM table to AST
	ast.from = [{table: req.params.table}];
	
	// Process WHERE recursively
	if(ast.where) ast.where = processWhere(ast.where);
	
	// Convert AST back to SQL
	var sql = parser.stringify.parse(ast);
	
	// Query database with SQL
	conn.query(sql, function(err, result) {
		if(err) console.error(err);
		res.json(result.rows);
		next();
	});
});

/**
 * Get tables & fields, then start the server
 */
var sql = 'select column_name AS name, udt_name AS type, table_name from INFORMATION_SCHEMA.COLUMNS where table_schema = \'public\';';
conn.query(sql, function(err, result) {
	if(err) return console.error(err);
	tables = _.groupBy(result.rows, 'table_name');
	
	server.listen(server_port, server_ip_address, function() {
		console.log('%s listening at %s', server.name, server.url);
	});
});
