# soda-postgres
Uses [node-soda2-parser](https://github.com/timwis/node-soda2-parser) to provide a Socrata-style SODA2 API in front of a postgres database

# Installation
1. Clone the repo
2. Install dependencies via `npm install`
3. Create a copy of `.env.sample` named `.env` and fill in the values, pointing it to a postgres database with postgis enabled

# Usage
To run a SODA2 API server, use `node index.js` Then query the API using SODA2 calls, ie. `http://localhost:8080/resource/table_name?$select=*&zip_code=19141`

# Examples
A demo server with the [Heart Healthy Screening Sites](https://www.opendataphilly.org/dataset/heart-healthy-screening-sites/resource/2c0d8231-e6b8-4598-8089-d1bcaf1bdaa6) dataset provides the following examples.
* [$select=zip_code, screening_type, geom](http://104.236.214.217/resource/sites?$select=zip_code, screening_type, geom)
* [$select=zip_code, count(*)&$group=zip_code](http://104.236.214.217/resource/sites?$select=zip_code,count(*)&$group=zip_code)
* [$select=convex_hull(geom) AS hull&zip_code=19146](http://104.236.214.217/resource/sites?$select=convex_hull(geom) AS hull&zip_code=19146)
* [$where=within_box(geom, -75.182324, 39.949259, -75.170769, 39.934494)](http://104.236.214.217/resource/sites?$where=within_box(geom,-75.182324,39.949259,-75.170769,39.934494))
* [$where=within_circle(geom, -75.163406, 39.952503, 1000)](http://104.236.214.217/resource/sites?$where=within_circle(geom,-75.163406,39.952503,1000))
* [$where=within_polygon(geom, 'MULTIPOLYGON (((-75.184290 39.926206,-75.168267 39.930942,-75.159473 39.923000,-75.171159 39.917874,-75.184290 39.926206)))')](http://104.236.214.217/resource/sites?$where=within_polygon(geom,%27MULTIPOLYGON%20(((-75.184290%2039.926206,-75.168267%2039.930942,-75.159473%2039.923000,-75.171159%2039.917874,-75.184290%2039.926206)))%27))
