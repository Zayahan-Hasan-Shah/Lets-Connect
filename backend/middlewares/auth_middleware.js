const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'supersecretkey';

const authMiddleware = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Expecting "Bearer <token>"

    if (!token) {
        return res.status(401).json({ success: false, message: 'No token provided' });
    }

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        req.user = decoded; // Save user info for later use
        next();
    } catch (err) {
        return res.status(403).json({ success: false, message: 'Invalid or expired token' });
    }
};

module.exports = authMiddleware;
