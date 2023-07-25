import './css/App.css'
import Dashboard from './Dashboard';
import Login from './Auth/Login'
import Insert_bangkhen from './Insert/Insert_bangkhen';
import Insert_monument from './Insert/Insert_monument';
import {BrowserRouter, Routes, Route} from 'react-router-dom';
import EditCars_bangkhen from './edit/EditBangKhen';
import EditCars_monument from './edit/EditMonument';
import CarBangKhen from './Station_Page/Car_bangkhen';
import CarMonument from './Station_Page/Car_Monument';
import CarSaiTai from './Station_Page/Car_SaiTai';
import Insert_SaiTai from './Insert/Insert_SaiTai';
import EditCars_SaiTai from './edit/EditSaiTai';
function App() {
  return (
    <BrowserRouter>
    <Routes>
      <Route path='/' element={<Dashboard />}></Route>
      <Route path='/login' element={<Login />}></Route>
      <Route path='/create/cars_bangkhen' element={<Insert_bangkhen/>}></Route>
      <Route path='/create/cars_monument' element={<Insert_monument/>}></Route>
      <Route path='/create/cars_saitai' element={<Insert_SaiTai/>}></Route>
      <Route path='/CarsBangKhen' element={<CarBangKhen/>}></Route>
      <Route path='/CarsMonument' element={<CarMonument/>}></Route>
      <Route path='/CarSaiTai' element={<CarSaiTai/>}></Route>
      <Route path='/carsEdit_BangKhen/:id' element={<EditCars_bangkhen/>}></Route>
      <Route path='/carsEdit_Monument/:id' element={<EditCars_monument/>}></Route>
      <Route path='/carsEdit_SaiTai/:id' element={<EditCars_SaiTai/>}></Route>

    </Routes>
    </BrowserRouter>
  )
}

export default App
