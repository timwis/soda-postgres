var parser = require('../node-soda2-parser'),
	restify = require('restify'),
	anyDB = require('any-db-postgres');
require('dotenv').load();

var conn = anyDB.createConnection(process.env.DATABASE_URL);
	
var server = restify.createServer();
server.use(restify.queryParser());

server.get('/', function(req, res, next) {
	var ast = parser.parse(req.query);
	ast.from = [{table: process.env.DB_TABLE}];
	var sql = parser.stringify.parse(ast);
	
	console.log(req.query, sql);
	
	var results = [];
	conn.query(sql).on('data', function(row) {
		results.push(row);
	})
	.on('end', function() {
		res.json(results);
	})
	.on('error', function(err) {
		console.error(err);
	});
	
	next();
});

server.listen(8080, function() {
	console.log('%s listening at %s', server.name, server.url);
});