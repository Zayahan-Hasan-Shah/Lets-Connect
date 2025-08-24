const chatService = require('../services/chat_service'); const upload = require('../middlewares/upload_middleware');

const sendMessageWithMedia = async (req, res) => {
    try {
        const { chat_id } = req.params;
        const { content } = req.body;
        let media_url = null;
        let media_type = 'text';

        if (req.file) {
            media_url = req.file.path;
            if (req.file.mimetype.startsWith('image/')) {
                media_type = 'image';
            } else if (req.file.mimetype.startsWith('video/')) {
                media_type = 'video';
            } else if (req.file.mimetype.startsWith('audio/')) {
                media_type = 'voice';
            } else {
                media_type = 'document';
            }
        }

        const message = await chatService.sendMessage(chat_id, req.user.id, {
            content,
            media_url,
            media_type
        });
        res.status(201).json({ success: true, message });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const createPersonalChat = async (req, res) => {
    try {
        const { user_id } = req.body; // The other user's ID
        const chat = await chatService.createPersonalChat(req.user.id, user_id);
        res.status(201).json({ success: true, chat });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const createGroupChat = async (req, res) => {
    try {
        const { group_name, group_description, participants } = req.body;
        const chat = await chatService.createGroupChat(req.user.id, {
            group_name,
            group_description,
            participants
        });
        res.status(201).json({ success: true, chat });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const sendMessage = async (req, res) => {
    try {
        const { chat_id } = req.params;
        const { content, media_url, media_type } = req.body;
        const message = await chatService.sendMessage(chat_id, req.user.id, {
            content,
            media_url,
            media_type
        });
        res.status(201).json({ success: true, message });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const getChatMessages = async (req, res) => {
    try {
        const { chat_id } = req.params;
        const messages = await chatService.getChatMessages(chat_id, req.user.id);
        res.json({ success: true, messages });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

const getUserChats = async (req, res) => {
    try {
        const chats = await chatService.getUserChatsWithMessages(req.user.id);
        res.json({ success: true, chats });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

module.exports = {
    createPersonalChat,
    createGroupChat,
    sendMessage,
    getChatMessages,
    getUserChats,
    sendMessageWithMedia
};