const express = require('express');
const router = express.Router();
const { body } = require('express-validator');
const authController = require('../controllers/auth_controller');

// POST /auth/signup
router.post(
  '/signup',
  [
    body('email').isEmail().withMessage('Valid email is required').normalizeEmail(),
    body('username').isLength({ min: 3 }).withMessage('Username must be at least 3 characters').trim().escape(),
    body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
    body('phone').matches(/^\+?[0-9]{7,15}$/).withMessage('Invalid phone number format'),
  ],
  authController.signup
);

router.post(
  '/login',
  [
    body('email').isEmail().withMessage('Valid email is required').normalizeEmail(),
    body('password').notEmpty().withMessage('Password is required'),
  ],
  authController.login
);

module.exports = router;