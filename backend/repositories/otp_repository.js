const dbOtp = require('../config/db');

const createOtp = async ({ phone, code, expiresAt }) => {
  const sql = 'INSERT INTO otps (phone, code, expires_at) VALUES (?, ?, ?)';
  const [result] = await dbOtp.query(sql, [phone, code, expiresAt]);
  const [rows] = await dbOtp.query('SELECT * FROM otps WHERE id = ?', [result.insertId]);
  return rows[0];
};

const findOtp = async (phone, code) => {
  const [rows] = await dbOtp.query('SELECT * FROM otps WHERE phone = ? AND code = ?', [phone, code]);
  return rows[0];
};

const deleteOtp = async (phone) => {
  await dbOtp.query('DELETE FROM otps WHERE phone = ?', [phone]);
};

module.exports = { createOtp, findOtp, deleteOtp };