const express = require('express');
const BookingCars = require('../../controllers/Users/users_booking');
const router = express.Router();

router.post('/create/cars', BookingCars.booking_cars);
router.get('/get/user/:id', BookingCars.booking_users);
router.post('/create/qrcode', BookingCars.qrCode);

module.exports = router;