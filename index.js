var parser = require('../node-soda2-parser'),
	restify = require('restify'),
	_ = require('underscore'),
	astToPsql = require('./ast-to-postgresql'),
	anyDB = require('any-db-postgres');
require('dotenv').load();
var inspect = function(data) { console.log(require('util').inspect(data, false, 10, true)); };

var conn = anyDB.createConnection(process.env.DATABASE_URL);
	
var server = restify.createServer();
server.use(restify.queryParser());

var tables = {};

server.get('/resource/:table', function(req, res, next) {
	// If table doesn't exist, send error
	if(tables[req.params.table] === undefined) {
		return res.send(404);
	}
	var ast = parser.parse(req.query),
		sql = astToPsql(ast, req.params.table, tables[req.params.table]);
	
	// Query database
	//console.log(req.query, sql);
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
	
	server.listen(8080, function() {
		console.log('%s listening at %s', server.name, server.url);
	});
});
