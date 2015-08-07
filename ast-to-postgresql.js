/*
{ expr: { type: 'column_ref', table: '', column: 'id' },
       as: null }
*/
var parser = require('node-soda2-parser'),
	_ = require('underscore');

var buildAstColumn = function(column, alias, table) {
	return {
		expr: {
			type: 'column_ref',
			table: table || '',
			column: column
		},
		as: alias || null
	};
}

module.exports = function(ast, table, fields) {
	// If SELECT is *, replace with fields
	if(ast.columns === '*') {
		ast.columns = [];
		fields.forEach(function(field) {
			ast.columns.push(buildAstColumn(field.name));
		});
	}
	
	// Add FROM table to AST
	ast.from = [{table: table}];
	
	// Wrap any SELECTs of geometry type columns in ST_AsGeoJSON()
	ast.columns.forEach(function(col) {
		if(col.expr.type === 'column_ref') {
			var field = _.findWhere(fields, {name: col.expr.column});
			if(field && field.type === 'geometry') {
				var fieldName = col.expr.column;
				col.expr = {type: 'aggr_func', name: 'ST_AsGeoJSON', args: { expr: col.expr } };
				if(col.as === undefined || ! col.as) col.as = fieldName;
			}
		}
	});
	
	// Convert AST back to SQL
	var sql = parser.stringify.parse(ast);
	
	// Cast any GeoJSON references to json
	sql = sql.replace(/ST_AsGeoJSON\((.+?)\)/g, 'ST_AsGeoJSON($1)::json'); 
	
	return sql;
};