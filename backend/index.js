const express = require('express');
const { createUsersTable } = require('./models/user_model');
const db = require('./config/db');


const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');

const app = express();

(async () => {
  await db.query(createUsersTable);
})();

app.use(express.json())

app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/users', userRoutes);

const PORT = process.env.PORT;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));