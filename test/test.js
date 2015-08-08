var should = require('should'),
	parser = require('node-soda2-parser'),
	processWhere = require('../lib/where'),
	processSelect = require('../lib/select'),
  fields = require('./data/fields');

function inspect(obj) {
  console.log(require('util').inspect(obj, false, 10, true));
}

describe('select',function() {

  it('multiple fields', function() {
    var ast = parser.parse('$select=foo, bar')
    ast.columns = processSelect(ast.columns, fields)
    var sql = parser.stringify.parse(ast)
    sql.should.eql('SELECT foo, bar')
  })
  
  it('wildcard', function() {
    var ast = parser.parse('$select=*')
    ast.columns = processSelect(ast.columns, fields)
    var sql = parser.stringify.parse(ast)
    sql.should.eql('SELECT id, date, time, address, location, city, state, zip_code, screening_type, contact_information, phone_number, ST_AsGeoJSON(geom)::json AS geom')
  })
  
  // Fails because of regex that appends ::json not being greedy
  it('convex hull', function() {
    var ast = parser.parse('$select=convex_hull(geom)')
    ast.columns = processSelect(ast.columns, fields)
    var sql = parser.stringify.parse(ast)
    sql.should.eql('SELECT ST_AsGeoJSON(ST_ConvexHull(ST_Collect(geom)))::json')
  })
  
})

describe('where', function() {
  
  it('operator', function() {
    var ast = parser.parse('$where=foo < 3')
    ast.where = processWhere(ast.where)
    var sql = parser.stringify.parse(ast)
    sql.should.eql('SELECT * WHERE foo < 3')
  })
  
  it('within box', function() {
    var ast = parser.parse('$where=within_box(geom, 47.5, -122.3, 47.5, -122.3)')
    ast.where = processWhere(ast.where)
    var sql = parser.stringify.parse(ast)
    sql.should.eql('SELECT * WHERE geom && ST_MakeEnvelope(47.5, -122.3, 47.5, -122.3, 4326)')
  })
  
  it('within circle', function() {
    var ast = parser.parse('$where=within_circle(geom, 47.59815, -122.33454, 500)')
    ast.where = processWhere(ast.where)
    var sql = parser.stringify.parse(ast)
    sql.should.eql('SELECT * WHERE ST_Point_Inside_Circle(geom, 47.59815, -122.33454, 0.005)')
  })
  
  it('within polygon', function() {
    var ast = parser.parse('$where=within_polygon(geom, \'MULTIPOLYGON (((-87.637714 41.887275, -87.613681 41.886892, -87.625526 41.871555, -87.637714 41.887275)))\')')
    ast.where = processWhere(ast.where)
    var sql = parser.stringify.parse(ast)
    sql.should.eql('SELECT * WHERE ST_Within(geom, ST_GeometryFromText(\'MULTIPOLYGON (((-87.637714 41.887275, -87.613681 41.886892, -87.625526 41.871555, -87.637714 41.887275)))\'))')
  })
  
  it('multiple', function() {
    var ast = parser.parse('$where=foo < 2 and within_box(geom, 47.5, -122.3, 47.5, -122.3) AND bar = \'test\'')
    ast.where = processWhere(ast.where)
    var sql = parser.stringify.parse(ast)
    sql.should.eql('SELECT * WHERE foo < 2 AND geom && ST_MakeEnvelope(47.5, -122.3, 47.5, -122.3, 4326) AND bar = \'test\'')
  })
  
})