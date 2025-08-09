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
        console.log(`✅ Data : ${result.user}`);
        return res.status(201).json({
            success: true,
            user: result.user,
            message: 'Signup successful. Please verify your phone via /otp/send-otp.'
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


module.exports = { signup, login };