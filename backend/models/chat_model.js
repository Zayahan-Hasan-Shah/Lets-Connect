const createChatsTable = `
CREATE TABLE IF NOT EXISTS chats (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  is_group BOOLEAN DEFAULT FALSE,
  group_name VARCHAR(255) DEFAULT NULL,
  group_description TEXT DEFAULT NULL,
  created_by BIGINT DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
`;

const createChatParticipantsTable = `
CREATE TABLE IF NOT EXISTS chat_participants (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  chat_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  joined_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_participant (chat_id, user_id),
  FOREIGN KEY (chat_id) REFERENCES chats(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
`;

const createMessagesTable = `
CREATE TABLE IF NOT EXISTS messages (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  chat_id BIGINT NOT NULL,
  sender_id BIGINT NOT NULL,
  content TEXT DEFAULT NULL,
  media_url VARCHAR(500) DEFAULT NULL,
  media_type ENUM('text', 'image', 'video', 'document', 'voice') DEFAULT 'text',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (chat_id) REFERENCES chats(id) ON DELETE CASCADE,
  FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
`;

module.exports = {
    createChatsTable,
    createChatParticipantsTable,
    createMessagesTable
};