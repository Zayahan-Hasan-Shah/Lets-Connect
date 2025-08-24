require('dotenv').config();
const express = require('express');
const db = require('./config/db');
const { createUsersTable } = require('./models/user_model');
const { createPostsTable, createCommentsTable, createLikesTable } = require('./models/post_model');
const { createChatsTable, createMessagesTable, createChatParticipantsTable } = require('./models/chat_model');

const app = express();

app.use(express.json());

// Routes
const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
const postRoutes = require('./routes/post');
const chatRoutes = require('./routes/chat');
app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/users/', userRoutes);
app.use('/api/v1/posts', postRoutes);
app.use('/api/v1/chats', chatRoutes);
app.use('/uploads', express.static('uploads'));
// Function to ensure required tables exist
const initDatabase = async () => {
    try {
        console.log('🔍 Checking & creating tables if missing...');
        await db.query(createUsersTable);
        console.log('✅ Users table ready');

        await db.query(createPostsTable);
        console.log('✅ Posts table ready');

        await db.query(createLikesTable);
        console.log('✅ Likes table ready');

        await db.query(createCommentsTable);
        console.log('✅ Comments table ready');

        await db.query(createChatsTable);
        console.log('✅ Chats table ready');

        await db.query(createChatParticipantsTable);
        console.log('✅ Chat participants table ready');

        await db.query(createMessagesTable);
        console.log('✅ Messages table ready');
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
