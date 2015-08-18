var _ = require('underscore');

// SELECT processor
module.exports = function(columns, fields) {

	// If SELECT is *, replace with fields (so we can output geometry fields as GeoJSON)
	if(columns === '*') {
		columns = [];
		fields.forEach(function(field) {
			columns.push({
				expr: {
					type: 'column_ref',
					table: '',
					column: field.name
				},
				as: null
			});
		});
	}
	console.log(fields)
	columns.forEach(function(col) {
		if(col.expr.type === 'column_ref') {
			// Wrap any geometry type columns in ST_AsGeoJSON()::json
			var field = _.findWhere(fields, {name: col.expr.column});
			if(field && field.type === 'geometry') {
				var fieldName = col.expr.column;
				col.expr = {
					type: 'raw',
					value: 'ST_AsGeoJSON(' + col.expr.column + ')::json'
				};
				if(col.as === undefined || ! col.as) col.as = '"' + (field.alias || fieldName) + '"';
			}
		}
		else if(col.expr.type === 'aggr_func') {
			// convex_hull()
			if(col.expr.name === 'convex_hull') {
				col.expr = {
					type: 'raw',
					value: 'ST_AsGeoJSON(ST_ConvexHull(ST_Collect(' + col.expr.args.expr.column + ')))::json'
				};
			}
		}
	});
	return columns;
}
