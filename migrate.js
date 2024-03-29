require('dotenv').config();
const fs = require('fs/promises');

const DB_URL = process.env.DB_URL || 'postgres://catuser:catuserpassword@localhost:5432/catfacts';
const pgp = require('pg-native');
const db = new pgp();
db.connectSync(DB_URL);

(async () => {
  try {
    const data = await fs.readFile('import.sql', { encoding: 'utf8' });
    let count = 0;
    for (let command of data.split("\n")) {
      if (!command) {
        continue;
      }

      db.querySync(command);
      if (command.includes('insert into facts')) {
        count++;
      }
    }
    console.log(`Done! Inserted ${count} rows`);
  } catch (e) {
    console.error(e);
  }
})();
