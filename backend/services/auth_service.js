const bcrypt = require('bcrypt');
const userRepo = require('../repositories/user_repository');
const { signToken } = require('../utils/jwt');
const { sendEmail } = require('../utils/email');

const signup = async ({ email, username, password, phone }) => {
    email = normalizeEmail(email); // ✅ Normalize before using

    const existsEmail = await userRepo.findByEmail(email);
    if (existsEmail) throw new Error('Email already in use');

    const existsUser = await userRepo.findByUsername(username);
    if (existsUser) throw new Error('Username already in use');

    const existsPhone = await userRepo.findByPhone(phone);
    if (existsPhone) throw new Error('Phone number already in use');

    const hashed = await bcrypt.hash(password, 12);
    const user = await userRepo.createUser({ email, username, password: hashed, phone });

    const safeUser = { id: user.id, email: user.email, username: user.username, phone: user.phone };
    return { user: safeUser };
};

const login = async ({ email, password }) => {
    email = normalizeEmail(email); // ✅ Normalize before query

    const user = await userRepo.findByEmail(email);
    if (!user) throw new Error('Invalid email or password');

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) throw new Error('Invalid email or password');

    const safeUser = { id: user.id, email: user.email, username: user.username, phone: user.phone };
    const token = signToken(safeUser);

    return { user: safeUser, token };
};


const forgotPassword = async (email) => {
    const user = await userRepo.findByEmail(email);
    console.log("MKC USER", user)
    if (!user) {
        throw new Error('User with this email does not exist');
    }

    // Generate random password
    const randomPassword = Math.random().toString(36).slice(-8); // 8 chars
    const hashed = await bcrypt.hash(randomPassword, 12);

    // Update password in DB
    await userRepo.updatePassword(user.id, hashed);

    // Send email with new password
    await sendEmail(email, 'Your New Password', `Your new password is: ${randomPassword}`);

    return { message: 'New password sent to your email' };
};

const changePassword = async (userId, currentPassword, newPassword, confirmPassword) => {
    if (newPassword !== confirmPassword) {
        throw new Error('New password and confirm password do not match');
    }

    const user = await userRepo.findById(userId);
    if (!user) {
        throw new Error('User not found');
    }

    const isMatch = await bcrypt.compare(currentPassword, user.password);
    if (!isMatch) {
        throw new Error('Current password is incorrect');
    }

    const hashed = await bcrypt.hash(newPassword, 12);
    await userRepo.updatePassword(user.id, hashed);

    return { message: 'Password updated successfully' };
};

module.exports = { signup, login, forgotPassword, changePassword };