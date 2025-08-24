const postService = require('../services/post_service');
const upload = require('../middlewares/upload_middleware');

const createPostWithMedia = async (req, res) => {
    try {
        const { content } = req.body;
        let media_url = null;
        let media_type = 'none';

        if (req.file) {
            media_url = req.file.path;
            if (req.file.mimetype.startsWith('image/')) {
                media_type = 'image';
            } else if (req.file.mimetype.startsWith('video/')) {
                media_type = 'video';
            } else {
                media_type = 'document';
            }
        }

        const post = await postService.createPost(req.user.id, { content, media_url, media_type });
        res.status(201).json({ success: true, post });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const createPost = async (req, res) => {
    try {
        const { content, media_url, media_type } = req.body;
        const post = await postService.createPost(req.user.id, { content, media_url, media_type });
        res.status(201).json({ success: true, post });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const updatePost = async (req, res) => {
    try {
        const { id } = req.params;
        const { content, media_url, media_type } = req.body;
        const post = await postService.updatePost(id, req.user.id, { content, media_url, media_type });
        res.json({ success: true, post });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const deletePost = async (req, res) => {
    try {
        const { id } = req.params;
        await postService.deletePost(id, req.user.id);
        res.json({ success: true, message: 'Post deleted successfully' });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const getUserPosts = async (req, res) => {
    try {
        const { user_id } = req.params;
        const posts = await postService.getUserPosts(user_id);
        res.json({ success: true, posts });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const getAllPosts = async (req, res) => {
    try {
        const posts = await postService.getAllPosts();
        res.json({ success: true, posts });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const likePost = async (req, res) => {
    try {
        const { post_id } = req.params;
        const like = await postService.likePost(req.user.id, post_id);
        res.json({ success: true, like });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const unlikePost = async (req, res) => {
    try {
        const { post_id } = req.params;
        await postService.unlikePost(req.user.id, post_id);
        res.json({ success: true, message: 'Post unliked successfully' });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const addComment = async (req, res) => {
    try {
        const { post_id } = req.params;
        const { content } = req.body;
        const comment = await postService.addComment(req.user.id, post_id, content);
        res.status(201).json({ success: true, comment });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const getPostDetails = async (req, res) => {
    try {
        const { post_id } = req.params;
        const postDetails = await postService.getPostDetails(post_id);
        res.json({ success: true, ...postDetails });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

module.exports = {
    createPost,
    updatePost,
    deletePost,
    getUserPosts,
    getAllPosts,
    likePost,
    unlikePost,
    addComment,
    getPostDetails,
    createPostWithMedia
};