const express = require('express');
const { createUsersTable } = require('./models/user_model');
const { createOtpsTable } = require('./models/otp_model');
const db = require('./config/db');


const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
const otpRoutes = require('./routes/otp');

const app = express();

(async () => {
  await db.query(createUsersTable);
  await db.query(createOtpsTable);
})();

app.use(express.json())

app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/users', userRoutes);
app.use('/api/v1/otp', otpRoutes);

const PORT = process.env.PORT;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));