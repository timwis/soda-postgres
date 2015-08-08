/*
{ expr: { type: 'column_ref', table: '', column: 'id' },
       as: null }
*/
var parser = require('node-soda2-parser'),
	_ = require('underscore');

function inspect(obj) {
  console.log(require('util').inspect(obj, false, 10, true));
}

// Recursive WHERE processor
var processWhere = function(expr) {
	// If AND or OR, recurse
	if(expr.type === 'binary_expr' && (expr.operator === 'AND' || expr.operator === 'OR')) {
		expr.left = processWhere(expr.left);
		expr.right = processWhere(expr.right);
	} else if(expr.type === 'function') {
		// within_box()
		if(expr.name === 'within_box') {
			var field = expr.args.value.shift().column,
				points = _.pluck(expr.args.value, 'value');
			expr = {
				type: 'raw',
				value: field + ' && ST_MakeEnvelope(' + points.join(', ') + ', 4326)' 
			};
		}
		// within_circle()
		else if(expr.name === 'within_circle') {
			expr.name = 'ST_Point_Inside_Circle';
			expr.args.value[expr.args.value.length-1].value *= 0.00001; // convert degrees to meters
		}
		// within_polygon()
		else if(expr.name === 'within_polygon') {
			expr = {
				type: 'raw',
				value: 'ST_Within(' + expr.args.value[0].column + ', ST_GeometryFromText(\'' + expr.args.value[1].value + '\'))'
			};
		}
	}
	return expr;
}

module.exports = function(ast, table, fields) {
	// If SELECT is *, replace with fields
	if(ast.columns === '*') {
		ast.columns = [];
		fields.forEach(function(field) {
			ast.columns.push({
				expr: {
					type: 'column_ref',
					table: '',
					column: field.name
				},
				as: null
			});
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
				col.expr = {
					type: 'raw',
					value: 'ST_AsGeoJSON(' + col.expr.column + ')::json'
				};
				if(col.as === undefined || ! col.as) col.as = fieldName;
			}
		} else if(col.expr.type === 'aggr_func') {
			if(col.expr.name === 'convex_hull') {
				col.expr = {
					type: 'raw',
					value: 'ST_AsGeoJSON(ST_ConvexHull(ST_Collect(' + col.expr.args.expr.column + ')))::json'
				};
			}
		}
	});
	
	// Process WHERE recursively
	if(ast.where) ast.where = processWhere(ast.where);
	
	// Convert AST back to SQL
	var sql = parser.stringify.parse(ast);
	
	return sql;
};