# soda-postgres
Use Socrata's SODA2 API to query a postgres database

# Installation
1. Clone the repo
2. Install dependencies via `npm install`
3. Create a copy of `.env.sample` named `.env` and fill in the values, pointing it to a postgres database with postgis enabled

# Usage
To run a SODA2 API server, use `node index.js` Then query the API using SODA2 calls, ie. `http://localhost:8080/?$select=*&zip_code=19141`

# Examples
* [$select=zip_code, screening_type, geom](http://104.236.214.217/resource/sites?$select=zip_code, screening_type, geom)
* [$select=convex_hull(geom) AS hull&zip_code=19146](http://104.236.214.217/resource/sites?$select=convex_hull(geom) AS hull&zip_code=19146)
* [$where=within_box(geom,-75.182324,39.949259,-75.170769,39.934494)](http://104.236.214.217/resource/sites?$where=within_box(geom,-75.182324,39.949259,-75.170769,39.934494))
* [$where=within_circle(geom,-75.163406,39.952503,1000)](http://104.236.214.217/resource/sites?$where=within_circle(geom,-75.163406,39.952503,1000))
* $where=within_polygon(geom, 'MULTIPOLYGON (((-87.637714 41.887275, -87.613681 41.886892, -87.625526 41.871555, -87.637714 41.887275)))')
