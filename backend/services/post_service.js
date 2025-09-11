const postRepo = require('../repositories/post_repository');

const createPost = async (user_id, { content, media_url, media_type }) => {
    return await postRepo.createPost({ user_id, content, media_url, media_type });
};

const updatePost = async (post_id, user_id, { content, media_url, media_type }) => {
    const post = await postRepo.getPostById(post_id);
    if (!post) throw new Error('Post not found');
    if (post.user_id !== user_id) throw new Error('Not authorized to update this post');
    
    return await postRepo.updatePost(post_id, { content, media_url, media_type });
};

const deletePost = async (post_id, user_id) => {
    const post = await postRepo.getPostById(post_id);
    if (!post) throw new Error('Post not found');
    if (post.user_id !== user_id) throw new Error('Not authorized to delete this post');
    
    return await postRepo.deletePost(post_id);
};

const getUserPosts = async (user_id) => {
    return await postRepo.getUserPosts(user_id);
};

const getAllPosts = async (page, limit) => {
    return await postRepo.getAllPosts(page, limit);
};

const likePost = async (user_id, post_id) => {
    return await postRepo.likePost(user_id, post_id);
};

const unlikePost = async (user_id, post_id) => {
    return await postRepo.unlikePost(user_id, post_id);
};

const addComment = async (user_id, post_id, content) => {
    return await postRepo.addComment({ user_id, post_id, content });
};

const getPostDetails = async (post_id) => {
    const post = await postRepo.getPostById(post_id);
    if (!post) throw new Error('Post not found');
    
    const likes = await postRepo.getLikes(post_id);
    const comments = await postRepo.getComments(post_id);
    
    return {
        post,
        likes: {
            count: likes.length,
            users: likes
        },
        comments
    };
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
    getPostDetails
};