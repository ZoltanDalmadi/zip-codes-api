const { send } = require("micro");
const { router, get } = require("microrouter");
const util = require('util');

const sqlite3 = require("sqlite3");
const db = new sqlite3.Database("zips.db");

const db_all = util.promisify(db.all.bind(db));

const getCountries = async () => await db_all(
  "SELECT * FROM countries");

const getCities = async req => {
  const cities = await db_all(
    `SELECT cities.id, cities.name FROM cities
    JOIN countries ON cities.country_id=countries.id
    WHERE countries.name=?`, req.params.name);

  // sub-query to get all zip codes for each city
  return Promise.all(
    cities.map(async city => ({ ...city,
      zips: (await db_all("SELECT name FROM zips where city_id=?", city.id)).map(zip => zip.name)
    })));
};

const getZips = async req => await db_all(
  `SELECT name as zip FROM zips
  WHERE city_id=?`, req.params.id);

const notFound = (req, res) => send(res, 404);

module.exports = router(
  get("/countries", getCountries),
  get("/cities/:name", getCities),
  get("/zips/:id", getZips),
  get("/*", notFound)
);
