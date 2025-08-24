const express = require('express');
const router = express.Router();
const chatController = require('../controllers/chat_controller');
const authMiddleware = require('../middlewares/auth_middleware');
const upload = require('../middlewares/upload_middleware');

// All routes require authentication
router.use(authMiddleware);

// Chat routes
router.post('/personal', chatController.createPersonalChat);
router.post('/group', chatController.createGroupChat);
router.get('/user-chats', chatController.getUserChats);

// Message routes
router.post('/:chat_id/message', upload.single('media'), chatController.sendMessageWithMedia);
router.get('/:chat_id/messages', chatController.getChatMessages);

module.exports = router;