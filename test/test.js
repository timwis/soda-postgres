var should = require('should'),
	parser = require('node-soda2-parser'),
	astToPsql = require('../ast-to-postgresql'),
  fields = require('./fields');

function inspect(obj) {
  console.log(require('util').inspect(obj, false, 10, true));
}

describe('select',function(){

  it('multiple fields', function() {
    var ast = parser.parse('$select=foo, bar'),
			sql = astToPsql(ast, 'sites', fields)
    sql.should.eql('SELECT foo, bar FROM sites')
  });
  
  it('wildcard', function() {
    var ast = parser.parse('$select=*'),
      sql = astToPsql(ast, 'sites', fields)
    sql.should.eql('SELECT id, date, time, address, location, city, state, zip_code, screening_type, contact_information, phone_number, ST_AsGeoJSON(geom)::json AS geom FROM sites')
  })
});