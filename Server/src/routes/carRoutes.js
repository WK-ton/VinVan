const express = require('express');
const CarController = require ('../controllers/Admin/carController');
const router = express.Router();
const upload = require('../middleware/multer');

router.post('/create', upload.single('image'),CarController.create);
router.get('/getCars', CarController.getCars);
router.get('/get/:id', CarController.getCarById);
router.get('/number', CarController.getAllNumber);
router.put('/update/:id', CarController.updateCar);
router.delete('/delete/:id', CarController.deleteCar);
router.get('/image', CarController.getCarImage);
// router.get('/', CarController.getNumber)
module.exports = router;