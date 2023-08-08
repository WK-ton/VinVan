const express = require('express');
const BookingCars = require('../../controllers/Users/users_booking');
const router = express.Router();

router.post('/create/cars', BookingCars.booking_cars);
// router.get('/getCars/cars_bangkhen', CarsBangkhen.getCars_carsBangKhen);
// router.get('/get/cars_bangkhen/:id', CarsBangkhen.getCarById_carsBangKhen);
// router.get('/number', CarController.getAllNumber);
// router.put('/update/cars_bangkhen/:id', CarsBangkhen.updateCar_carsBangKhen);
// router.delete('/delete/cars_bangkhen/:id', CarsBangkhen.deleteCar_carsBangKhen);
// router.get('/image', CarController.getCarImage);
// router.get('/', CarController.getNumber)
module.exports = router;