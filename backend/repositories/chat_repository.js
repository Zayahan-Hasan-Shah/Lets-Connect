const db = require('../config/db');

const createChat = async ({ is_group, group_name, group_description, created_by }) => {
    const [result] = await db.query(
        'INSERT INTO chats (is_group, group_name, group_description, created_by) VALUES (?, ?, ?, ?)',
        [is_group, group_name, group_description, created_by]
    );
    return { id: result.insertId, is_group, group_name, group_description, created_by };
};

const getChatById = async (id) => {
    const [rows] = await db.query(`
        SELECT c.*, u.username as created_by_username 
        FROM chats c 
        LEFT JOIN users u ON c.created_by = u.id 
        WHERE c.id = ?
    `, [id]);
    return rows[0];
};

const addParticipant = async (chat_id, user_id) => {
    const [result] = await db.query(
        'INSERT INTO chat_participants (chat_id, user_id) VALUES (?, ?)',
        [chat_id, user_id]
    );
    return { id: result.insertId, chat_id, user_id };
};

const getChatParticipants = async (chat_id) => {
    const [rows] = await db.query(`
        SELECT cp.*, u.username, u.email 
        FROM chat_participants cp 
        JOIN users u ON cp.user_id = u.id 
        WHERE cp.chat_id = ?
    `, [chat_id]);
    return rows;
};

const getUserChats = async (user_id) => {
    const [rows] = await db.query(`
        SELECT c.*, cp.joined_at 
        FROM chats c 
        JOIN chat_participants cp ON c.id = cp.chat_id 
        WHERE cp.user_id = ? 
        ORDER BY c.created_at DESC
    `, [user_id]);
    return rows;
};

const createMessage = async ({ chat_id, sender_id, content, media_url, media_type }) => {
    const [result] = await db.query(
        'INSERT INTO messages (chat_id, sender_id, content, media_url, media_type) VALUES (?, ?, ?, ?, ?)',
        [chat_id, sender_id, content, media_url, media_type]
    );
    return { id: result.insertId, chat_id, sender_id, content, media_url, media_type };
};

const getChatMessages = async (chat_id) => {
    const [rows] = await db.query(`
        SELECT m.*, u.username as sender_username 
        FROM messages m 
        JOIN users u ON m.sender_id = u.id 
        WHERE m.chat_id = ? 
        ORDER BY m.created_at ASC
    `, [chat_id]);
    return rows;
};

module.exports = {
    createChat,
    getChatById,
    addParticipant,
    getChatParticipants,
    getUserChats,
    createMessage,
    getChatMessages
};