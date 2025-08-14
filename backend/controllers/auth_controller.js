const { validationResult } = require('express-validator');
const authService = require('../services/auth_service');

const signup = async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({ success: false, errors: errors.array() });
    }

    try {
        const { email, username, password, phone } = req.body;
        const result = await authService.signup({ email, username, password, phone });
        console.log("✅ Signup succesfull");
        console.log(`✅ Data : ${result.user.email}`);
        return res.status(201).json({
            success: true,
            user: result.user,
        });
    } catch (err) {
        console.error('[signup error]', err.message);
        console.error(`❌ Signup failed: ${err.message}`);
        return res.status(400).json({ success: false, message: err.message });
    }
};

const login = async (req, res) => {
    try {
        const { email, password } = req.body;
        const { user, token } = await authService.login({ email, password });
        console.log("✅ login succesfull");
        return res.status(200).json({ success: true, user, token });
    } catch (err) {
        return res.status(400).json({ success: false, message: err.message });
    }
};

const forgotPassword = async (req, res) => {
    try {
        const { email } = req.body;
        if (!email) {
            console.error("❌ Email missing in request body");
            return res.status(400).json({ success: false, message: err.message });
        }
        console.log(`🔍 Looking for user with email: ${email}`);
        const result = await authService.forgotPassword(email);
        console.log("✅ Forgot password process completed successfully");
        return res.status(200).json({ success: true, ...result });
    } catch (err) {
        console.error("💥 Error in forgot-password:", err.message);
        return res.status(400).json({ success: false, message: err.message });
    }
};

const changePassword = async (req, res) => {
    try {
        const { currentPassword, newPassword, confirmPassword } = req.body;
        const userId = req.user.id; // from authMiddleware
        const result = await authService.changePassword(userId, currentPassword, newPassword, confirmPassword);
        res.status(200).json({ success: true, ...result });
    } catch (err) {
        res.status(400).json({ success: false, message: err.message });
    }
};

module.exports = { signup, login, forgotPassword, changePassword };