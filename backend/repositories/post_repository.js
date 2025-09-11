const db = require('../config/db');

const createPost = async ({ user_id, content, media_url, media_type }) => {
    const [result] = await db.query(
        'INSERT INTO posts (user_id, content, media_url, media_type) VALUES (?, ?, ?, ?)',
        [user_id, content, media_url, media_type]
    );
    return { id: result.insertId, user_id, content, media_url, media_type };
};

const getPostById = async (id) => {
    const [rows] = await db.query(`
        SELECT p.*, u.username, u.email 
        FROM posts p 
        JOIN users u ON p.user_id = u.id 
        WHERE p.id = ?
    `, [id]);
    return rows[0];
};

const updatePost = async (id, { content, media_url, media_type }) => {
    await db.query(
        'UPDATE posts SET content = ?, media_url = ?, media_type = ? WHERE id = ?',
        [content, media_url, media_type, id]
    );
    return getPostById(id);
};

const deletePost = async (id) => {
    await db.query('DELETE FROM posts WHERE id = ?', [id]);
    return true;
};

const getUserPosts = async (user_id) => {
    const [rows] = await db.query(`
        SELECT p.*, u.username, u.email 
        FROM posts p 
        JOIN users u ON p.user_id = u.id 
        WHERE p.user_id = ? 
        ORDER BY p.created_at DESC
    `, [user_id]);
    return rows;
};

// const getAllPosts = async () => {
//     const [rows] = await db.query(`
//         SELECT p.*, u.username
//         FROM posts p 
//         JOIN users u ON p.user_id = u.id 
//         ORDER BY p.created_at DESC
//     `);
//     return rows;
// };

const getAllPosts = async (page = 1, limit = 20) => {
    const offset = (page - 1) * limit;

    const [rows] = await db.query(`
        SELECT p.*, u.username
        FROM posts p
        JOIN users u ON p.user_id = u.id
        ORDER BY p.created_at DESC
        LIMIT ? OFFSET ?
    `, [limit, offset]);


    const [[{ total }]] = await db.query(`SELECT COUNT(*) as total FROM posts`);


    return {
        posts: rows, total
    };
};

const likePost = async (user_id, post_id) => {
    const [result] = await db.query(
        'INSERT INTO likes (user_id, post_id) VALUES (?, ?)',
        [user_id, post_id]
    );
    return { id: result.insertId, user_id, post_id };
};

const unlikePost = async (user_id, post_id) => {
    await db.query(
        'DELETE FROM likes WHERE user_id = ? AND post_id = ?',
        [user_id, post_id]
    );
    return true;
};

const getLikes = async (post_id) => {
    const [rows] = await db.query(`
        SELECT l.*, u.username 
        FROM likes l 
        JOIN users u ON l.user_id = u.id 
        WHERE l.post_id = ?
    `, [post_id]);
    return rows;
};

const addComment = async ({ user_id, post_id, content }) => {
    const [result] = await db.query(
        'INSERT INTO comments (user_id, post_id, content) VALUES (?, ?, ?)',
        [user_id, post_id, content]
    );
    return { id: result.insertId, user_id, post_id, content };
};

const getComments = async (post_id) => {
    const [rows] = await db.query(`
        SELECT c.*, u.username 
        FROM comments c 
        JOIN users u ON c.user_id = u.id 
        WHERE c.post_id = ? 
        ORDER BY c.created_at ASC
    `, [post_id]);
    return rows;
};

module.exports = {
    createPost,
    getPostById,
    updatePost,
    deletePost,
    getUserPosts,
    getAllPosts,
    likePost,
    unlikePost,
    getLikes,
    addComment,
    getComments
};