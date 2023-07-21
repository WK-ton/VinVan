const express = require('express');
const authController = require('../controllers/Admin/authController');
const UserController = require('../controllers/Users/users_auth');
// const userMiddleware = require('../middleware/authentication');
const router = express.Router();

router.post('/sign-up', UserController.signUp);
router.post('/Adminlogin', authController.login);
router.post('/userLogin', UserController.userLogin);
router.get('/getUser/:id', UserController.getUsers);
router.get('/', UserController.getItem);
module.exports = router;