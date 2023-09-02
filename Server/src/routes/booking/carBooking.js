const express = require('express');
const BookingCars = require('../../controllers/Users/users_booking');
const router = express.Router();
const upload = require('../../middleware/multer');


router.post('/create/cars', upload.single('image'), BookingCars.booking_cars);
router.get('/check/cars', BookingCars.checkSeat);
router.get('/get/user/:id', BookingCars.booking_users);
router.post('/create/qrcode', BookingCars.qrCode);
router.post('/api/seats', BookingCars.reserve);
router.get('/api/getSeats', BookingCars.getseats);
module.exports = router;