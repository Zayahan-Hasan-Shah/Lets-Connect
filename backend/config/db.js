const mysql2 = require('mysql2');
const dotenv = require('dotenv');
dotenv.config();

const tempConnection = mysql2.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT || 3306,
});

tempConnection.query(`CREATE DATABASE IF NOT EXISTS \`${process.env.DB_NAME}\``, (err) => {
    if (err) {
        console.error(`❌ Error creating database: ${err.message}`);
        process.exit(1);
    }
    console.log(`✅ Database "${process.env.DB_NAME}" is ready.`);
    tempConnection.end();
});

const pool = mysql2.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
    waitForConnections: true,
    connectionLimit: 20,
});

pool.getConnection((err, connection) => {
    if (err) {
        console.error(`❌ Error connecting to MySQL: ${err.message}`);
    } else {
        console.log(`✅ Connected to MySQL`);
        console.log("📦 Using database:", process.env.DB_NAME);
        connection.release();
    }
});

module.exports = pool.promise();