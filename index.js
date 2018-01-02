const { send } = require("micro");
const { router, get } = require("microrouter");

const sqlite3 = require("sqlite3");
const db = new sqlite3.Database("zips.db");

// wraps sqlite call into a Promise
const db_all = (db, command, ...params) =>
  new Promise((resolve, reject) =>
    db.all(command, params, (err, rows) =>
      err ? reject(err) : resolve(rows)));

const getCountries = async () => await db_all(db,
  "SELECT * FROM countries");

const getCities = async req => {
  const cities = await db_all(db,
    `SELECT cities.id, cities.name FROM cities
    JOIN countries ON cities.country_id=countries.id
    WHERE countries.name=?`, req.params.name);

  // sub-query to get all zip codes for each city
  return Promise.all(
    cities.map(async city => ({ ...city,
      zips: (await db_all(db, "SELECT name FROM zips where city_id=?", city.id)).map(zip => zip.name)
    })));
};

const getZips = async req => await db_all(db,
  `SELECT name as zip FROM zips
  WHERE city_id=?`, req.params.id);

const notFound = (req, res) => send(res, 404);

module.exports = router(
  get("/countries", getCountries),
  get("/cities/:name", getCities),
  get("/zips/:id", getZips),
  get("/*", notFound)
);
