import pg from 'pg';
const {Pool} = pg;

const db = new Pool({
    user: 'postgres',
    host: 'dbservice',
    database: 'ams',
    password: 'postgres',
    port: 5432,
})

db.connect((err, client, release) => {
    if (err) {
      console.error("❌ Database connection error:", err)
    } else {
        console.log("✅ Database connected successfully!");
      //  release(); // Release the client back to the db
    }
  });

export default db;