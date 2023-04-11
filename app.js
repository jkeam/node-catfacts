require('dotenv').config();
const express = require('express');

const app = express();
const PORT = process.env.PORT || 3000;
const DB_URL = process.env.DB_URL || 'postgres://catuser:catuserpassword@localhost:5432/catfacts';

const pgp = require('pg-native');
const db = new pgp();
db.connectSync(DB_URL);

/**
 * Find by catfacts id.
 * @param {string} id Id of the desired fact
 * @returns Text of the fact
 */
const findById = (id) => {
  try {
    const parsedId = parseInt(id, 10);
    if (parsedId) {
      const results = db.querySync('SELECT * from facts where id = $1', [parsedId]);
      if (results && results.length > 0) {
        return results[0];
      }
    }
    return null;
  } catch(e) {
    console.error(e);
  }
};

app.get('/', (req, res) => {
  return res.send('Welcome to catfacts!');
});

app.get('/:id', async (req, res) => {
  const fact = await findById(req.params.id);
  if (!fact) {
    return res.send('Unable to find that catfact');
  }
  return res.send(fact.fact);
});

app.listen(PORT, (error) => {
  if(error) {
    console.error('Error occurred, server cannot start', error);
    return;
  }
  console.log(`Server is listening on port: ${PORT}`);
});
