const express = require('express');
const router = express.Router();
const userController = require('../controllers/user_controller');

router.get('/allusers', userController.getAllUsers);
router.get('/user-details/:id', userController.getUserById);

module.exports = router;