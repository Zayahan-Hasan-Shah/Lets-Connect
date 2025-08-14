require('dotenv').config();
const express = require('express');
const db = require('./config/db');
const { createUsersTable } = require('./models/user_model');

const app = express();

app.use(express.json());

// Routes
const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/users/', userRoutes);

// Function to ensure required tables exist
const initDatabase = async () => {
    try {
        console.log('🔍 Checking & creating tables if missing...');
        await db.query(createUsersTable);
        console.log('✅ Users table ready');
    } catch (err) {
        console.error('❌ Error creating tables:', err.message);
        process.exit(1);
    }
};

// Start server
const startServer = async () => {
    await initDatabase(); 
    const PORT = process.env.PORT || 5000;
    app.listen(PORT, () => {
        console.log(`🚀 Server running on port ${PORT}`);
    });
};

startServer();
