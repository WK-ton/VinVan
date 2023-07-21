import './App.css'
import Dashboard from './Dashboard';
import Login from './Login'
import Insert from './Insert';
import {BrowserRouter, Routes, Route} from 'react-router-dom';
import EditCars from './EditCars';
function App() {
  return (
    <BrowserRouter>
    <Routes>
      <Route path='/' element={<Dashboard />}></Route>
      <Route path='/login' element={<Login />}></Route>
      <Route path='/create' element={<Insert/>}></Route>
      <Route path='/carsEdit/:id' element={<EditCars/>}></Route>
    </Routes>
    </BrowserRouter>
  )
}

export default App
