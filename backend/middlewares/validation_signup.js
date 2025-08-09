const { body, validationResult } = require('express-validator');

const signupValidationRules = [
  body('email').isEmail().withMessage('Valid email is required'),
  body('username').isLength({ min: 3 }).withMessage('Username must be at least 3 characters'),
  body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
  body('phone').matches(/^\+?[0-9]{7,15}$/).withMessage('Valid phone number is required')
];

const validateSignup = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    console.log(`Validation Signup error : ${res.status(400).json({ errors: errors.array() })}`);
    return res.status(400).json({ errors: errors.array() });
  }
  next();
};

module.exports = {
  signupValidationRules,
  validateSignup
};