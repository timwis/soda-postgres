/*
{ expr: { type: 'column_ref', table: '', column: 'id' },
       as: null }
*/
var parser = require('node-soda2-parser'),
	_ = require('underscore');

function inspect(obj) {
  console.log(require('util').inspect(obj, false, 10, true));
}

var buildAstColumn = function(column, alias, table) {
	return {
		expr: {
			type: 'column_ref',
			table: table || '',
			column: column
		},
		as: alias || null
	};
};

var buildAstFunc = function(name, expr) {
	return {
		type: 'aggr_func',
		name: name,
		args: { expr: expr }
	}
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
			expr.type = 'raw';
			expr.value = field + ' && ST_MakeEnvelope(' + points.join(', ') + ', 4326)';
		}
		// within_circle()
		else if(expr.name === 'within_circle') {
			expr.name = 'ST_Point_Inside_Circle';
			expr.args.value[expr.args.value.length-1].value *= 0.00001; // convert degrees to meters
		}
		// within_polygon()
		else if(expr.name === 'within_polygon') {
			expr.name = 'ST_Within';
			expr.args.value[1] = buildAstFunc('ST_GeometryFromText', expr.args.value[1]);
		}
	}
	return expr;
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
				//col.expr = {type: 'aggr_func', name: 'ST_AsGeoJSON', args: { expr: col.expr } };
				col.expr = buildAstFunc('ST_AsGeoJSON', col.expr);
				if(col.as === undefined || ! col.as) col.as = fieldName;
			}
		} else if(col.expr.type === 'aggr_func') {
			if(col.expr.name === 'convex_hull') {
				col.expr.name = 'ST_AsGeoJSON';
				col.expr.args = {expr: buildAstFunc('ST_ConvexHull', buildAstFunc('ST_Collect', col.expr.args.expr))};
			}
		}
	});
	
	// Process WHERE recursively
	if(ast.where) ast.where = processWhere(ast.where);
	
	// Convert AST back to SQL
	var sql = parser.stringify.parse(ast);
	
	// Cast any GeoJSON references to json
	sql = sql.replace(/ST_AsGeoJSON\((.+?)\)/g, 'ST_AsGeoJSON($1)::json'); 
	
	return sql;
};