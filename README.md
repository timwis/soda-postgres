# soda2-db
Use Socrata's SODA2 API to query a database

# Installation
1. Clone the repo
2. Install dependencies via `npm install`
3. Create a copy of `.env.sample` named `.env` and fill in the values, pointing it to a postgres database and table

# Usage
To run a SODA2 API server, use `node index.js` Then query the API using SODA2 calls, ie. `http://localhost:8080/?$select=*&zip_code=19141`