var _ = require('underscore');

// Recursive WHERE processor
module.exports = function(expr) {
	// If AND or OR, recurse
	if(expr.type === 'binary_expr' && (expr.operator === 'AND' || expr.operator === 'OR')) {
		expr.left = module.exports(expr.left);
		expr.right = module.exports(expr.right);
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