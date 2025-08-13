const db = require('../config/db');

const createUser = async ({ email, username, password, phone }) => {
    const [result] = await db.query('INSERT INTO users (email, username, password, phone) VALUES (?, ?, ?, ?)', [email, username, password, phone]);
    return { id: result.insertId, email, username, phone };
};

const findByEmail = async (email) => {
    const [rows] = await db.query('SELECT * FROM users WHERE email = ?', [email]);
    return rows[0];
};

const findByUsername = async (username) => {
    const [rows] = await db.query('SELECT * FROM users WHERE username = ?', [username]);
    return rows[0];
};

const findByPhone = async (phone) => {
    const [rows] = await db.query('SELECT * FROM users WHERE phone = ?', [phone]);
    return rows[0];
};

const findById = async (id) => {
    const [rows] = await db.query('SELECT * FROM users WHERE id = ?', [id]);
    return rows[0];
}

const getAllUsers = async () => {
    const [rows] = await db.query('SELECT * FROM users');
    return rows;
};

const updatePassword = async (id, hashedPassword) => {
    await db.query('UPDATE users SET password = ? WHERE id = ?', [hashedPassword, id]);
};

module.exports = { createUser, findByEmail, findByUsername, findByPhone, findById, getAllUsers, updatePassword };