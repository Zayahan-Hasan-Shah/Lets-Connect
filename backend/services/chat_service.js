const chatRepo = require('../repositories/chat_repository');

const createPersonalChat = async (user1_id, user2_id) => {
    // Check if personal chat already exists
    const userChats = await chatRepo.getUserChats(user1_id);
    const existingChat = userChats.find(chat => 
        !chat.is_group && chat.participants?.includes?.(user2_id)
    );
    
    if (existingChat) return existingChat;
    
    const chat = await chatRepo.createChat({
        is_group: false,
        group_name: null,
        group_description: null,
        created_by: user1_id
    });
    
    await chatRepo.addParticipant(chat.id, user1_id);
    await chatRepo.addParticipant(chat.id, user2_id);
    
    return chat;
};

const createGroupChat = async (created_by, { group_name, group_description, participants }) => {
    const chat = await chatRepo.createChat({
        is_group: true,
        group_name,
        group_description,
        created_by
    });
    
    // Add creator as participant
    await chatRepo.addParticipant(chat.id, created_by);
    
    // Add other participants
    for (const participant_id of participants) {
        if (participant_id !== created_by) {
            await chatRepo.addParticipant(chat.id, participant_id);
        }
    }
    
    return chat;
};

const sendMessage = async (chat_id, sender_id, { content, media_url, media_type = 'text' }) => {
    // Verify user is participant of the chat
    const participants = await chatRepo.getChatParticipants(chat_id);
    const isParticipant = participants.some(p => p.user_id === sender_id);
    
    if (!isParticipant) throw new Error('Not a participant of this chat');
    
    return await chatRepo.createMessage({
        chat_id,
        sender_id,
        content,
        media_url,
        media_type
    });
};

const getChatMessages = async (chat_id, user_id) => {
    // Verify user is participant
    const participants = await chatRepo.getChatParticipants(chat_id);
    const isParticipant = participants.some(p => p.user_id === user_id);
    
    if (!isParticipant) throw new Error('Not a participant of this chat');
    
    return await chatRepo.getChatMessages(chat_id);
};

const getUserChatsWithMessages = async (user_id) => {
    const chats = await chatRepo.getUserChats(user_id);
    
    const chatsWithLastMessage = await Promise.all(
        chats.map(async (chat) => {
            const messages = await chatRepo.getChatMessages(chat.id);
            const lastMessage = messages.length > 0 ? messages[messages.length - 1] : null;
            const participants = await chatRepo.getChatParticipants(chat.id);
            
            return {
                ...chat,
                last_message: lastMessage,
                participants_count: participants.length,
                participants: participants.map(p => ({
                    id: p.user_id,
                    username: p.username,
                    email: p.email
                }))
            };
        })
    );
    
    return chatsWithLastMessage;
};

module.exports = {
    createPersonalChat,
    createGroupChat,
    sendMessage,
    getChatMessages,
    getUserChatsWithMessages
};