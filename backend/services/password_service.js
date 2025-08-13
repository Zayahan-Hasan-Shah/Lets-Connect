const bcrypt = require('bcrypt');
const userRepo = require('../repositories/user_repository');
const { sendEmail } = require('../utils/email');

// Generate a random password
const generateRandomPassword = (length = 10) => {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%';
    return Array.from({ length }, () => chars[Math.floor(Math.random() * chars.length)]).join('');
};

/**
 * Forgot password - generates a new password and emails it
 */
const forgotPassword = async (req, res) => {
    console.log("📩 Forgot Password request received:", req.body);

    try {
        const { email } = req.body;
        email = normalizeEmail(email);
        console.log(`🔍 Looking for user with email: ${email}`);

        const user = await userRepo.findByEmail(email);
        if (!user) {
            console.log(`❌ User with email ${email} not found`);
            return res.status(404).json({ success: false, message: 'User not found' });
        }

        // Generate random password
        const newPasswordPlain = Math.random().toString(36).slice(-8);
        console.log(`🔑 Generated new password (plain): ${newPasswordPlain}`);

        // Hash password
        const newPasswordHashed = await bcrypt.hash(newPasswordPlain, 12);
        console.log(`🔒 Hashed password: ${newPasswordHashed}`);

        // Update user password in DB
        await db.query('UPDATE users SET password = ? WHERE email = ?', [newPasswordHashed, email]);
        console.log(`✅ Password updated in database for ${email}`);

        // Send email
        const htmlContent = `
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto;">
                <h2 style="color: #4CAF50;">Password Reset Successful</h2>
                <p>Hello <strong>${user.username}</strong>,</p>
                <p>Your password has been reset. Here is your new password:</p>
                <p style="background: #f4f4f4; padding: 10px; font-size: 18px; border-radius: 5px;">
                    ${newPasswordPlain}
                </p>
                <p>Please log in and change it immediately.</p>
                <br/>
                <p>— LetsConnect Team</p>
            </div>
        `;

        await sendEmail({
            to: email,
            subject: "Your New Password - LetsConnect",
            html: htmlContent
        });

        console.log(`📧 Email with new password sent to ${email}`);

        return res.status(200).json({ success: true, message: 'New password sent to your email' });

    } catch (err) {
        console.error("💥 Error in forgot-password:", err.message);
        return res.status(500).json({ success: false, message: err.message });
    }
};


/**
 * Change password
 */
const changePassword = async (userId, currentPassword, newPassword) => {
    const user = await userRepo.findById(userId);
    if (!user) throw new Error('User not found');

    const isMatch = await bcrypt.compare(currentPassword, user.password);
    if (!isMatch) throw new Error('Current password is incorrect');

    const hashed = await bcrypt.hash(newPassword, 12);
    await userRepo.updatePassword(userId, hashed);

    return { success: true, message: 'Password changed successfully' };
};

module.exports = { forgotPassword, changePassword };
