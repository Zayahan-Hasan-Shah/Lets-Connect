const nodemailer = require('nodemailer');

function normalizeEmail(email) {
    if (!email || typeof email !== 'string') return email;
    const [localPart, domain = ''] = email.trim().toLowerCase().split('@');
    return `${localPart}@${domain}`;
}

const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: process.env.EMAIL_USER,  // Your Gmail address
        pass: process.env.EMAIL_PASS   // App password from Gmail
    }
});

/**
 * Send an HTML email
 * @param {string} to - Recipient email
 * @param {string} subject - Email subject
 * @param {string} html - HTML content
 */
const sendEmail = async (to, subject, html) => {
    try {
        await transporter.sendMail({
            from: `"LetsConnect" <${process.env.EMAIL_USER}>`,
            to,
            subject,
            html
        });
        console.log(`📧 Email sent to ${to}`);
    } catch (err) {
        console.error('❌ Error sending email:', err.message);
        throw new Error('Failed to send email');
    }
};

module.exports = { sendEmail, normalizeEmail };
