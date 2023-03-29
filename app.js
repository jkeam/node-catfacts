require('dotenv').config();
const express = require('express');

const app = express();
const PORT = process.env.PORT || 3000;
const DB_URL = process.env.DB_URL || 'postgres://catuser:catuserpassword@localhost:5432/catfacts';

const pgp = require('pg-promise')(/* options */)
const db = pgp(DB_URL);

/**
 * Find by id.
 * @param {string} id Id of the desired fact
 * @returns Text of the fact
 */
const findById = async (id) => {
  try {
    return await db.one('SELECT * from facts where id = $1', parseInt(id, 10));
  } catch(e) {
    console.error(e);
  }
};

app.get('/', (req, res) => {
  res.send('Welcome to catfacts!');
});

app.get('/:id', async (req, res) => {
  const data = await findById(req.params.id);
  if (!data) {
    return res.send('Unable to find that catfact');
  }
  res.send(data.fact);
});

app.listen(PORT, (error) => {
  if(error) {
    console.error('Error occurred, server cannot start', error);
    return;
  }
  console.log(`Server is listening on port: ${PORT}`);
});
