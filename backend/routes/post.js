const express = require('express');
const router = express.Router();
const postController = require('../controllers/post_controller');
const authMiddleware = require('../middlewares/auth_middleware');
const upload = require('../middlewares/upload_middleware');

// All routes require authentication
router.use(authMiddleware);

// Post routes
router.post('/create', upload.single('media'), postController.createPostWithMedia);
router.put('/update/:id', postController.updatePost);
router.delete('/delete/:id', postController.deletePost);
router.get('/user/:user_id', postController.getUserPosts);
router.get('/all', postController.getAllPosts);
router.get('/:post_id', postController.getPostDetails);

// Like routes
router.post('/like/:post_id', postController.likePost);
router.delete('/unlike/:post_id', postController.unlikePost);

// Comment routes
router.post('/comment/:post_id', postController.addComment);

module.exports = router;