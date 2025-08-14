const userRepo = require('../repositories/user_repository');

const getAllUsers = async (req, res) => {
    try {
        const users = await userRepo.getAllUsers();
        return res.status(200).json({ success: true, total_user : users.length, users });
    } catch (err) {
        return res.status(500).json({ success: false, message: err.message });
    }
};

const getUserById = async (req, res) => {
    try {
        const user = await userRepo.findById(req.params.id);
        if (!user) return res.status(404).json({ success: false, message: 'User not found' });
        return res.status(200).json({ success: true, user });
    } catch (err) {
        return res.status(500).json({ success: false, message: err.message });
    }
};

module.exports = { getAllUsers, getUserById };