import Nav from 'react-bootstrap/Nav';
import '../css/Station_Two.css'
import { useEffect, useState } from 'react';
import axios from 'axios';
import '../css/style.css'
import { Link } from 'react-router-dom';

function CarMonument() {
    const [data, setData] = useState('');
    useEffect(() => {
        axios.get('http://localhost:8081/carMonument/getCars/cars_monument')
        .then(res => {
            if(res.data.Status === "Success") {
                console.log(res.data.Result)
                setData(res.data.Result);
            } else {
                alert("Error")
            }
        })
        .catch(err => console.log(err));
    },[])
    const handleDelete = (id) => {
      axios.delete('http://localhost:8081/carMonument/delete/cars_monument/'+id)
      .then(res => {
        if(res.data.Status === "Success") {
          window.location.reload(true);
        } else {
            alert("Error")
        }
    })
    .catch(err => console.log(err));
    }
  return (
    <div>
    <Nav className='container' variant="pills" defaultActiveKey="/home">
      <Nav className='active'>
        <Nav.Link className="font" href='/'>HOME</Nav.Link>
      </Nav>
      <Nav className='active'>
        <Nav.Link className="font" href='/create/cars_monument'>+ CARS</Nav.Link>
      </Nav>
      <Nav>
      </Nav>
    </Nav>
    <div className="mt-4 px-5 pt-3 text-center">  
             <h4> CarsMonument </h4>
             <table className='table'>
                <thead>
                    <tr className='text-center'>
                        <th>ID</th>
                        <th>สถานีต้นทาง</th>
                        <th>สถานีต้นปลายทาง</th>
                        <th>เลขรถ</th>
                        <th>เส้นทางที่ผ่าน</th>
                        <th>เวลารถออก</th>
                        <th>รูป</th>
                        <th>Action</th>
                    </tr>
                    </thead>        
                <tbody>
                    {data&&data.map((cars,index) => { 
                      return <tr key={index}>
                            <td>{cars.id}</td>
                            <td>{cars.fromstation}</td>
                            <td>{cars.tostation}</td>
                            <td>{cars.number}</td>
                            <td>{cars.road}</td>
                            <td>{cars.time}</td>
                            <td>{<img 
                            src={`http://localhost:8081/images/`+ cars.image} 
                            alt="" 
                            className='cars_images' 
                            style={{width:'100px', height:'100px'}}
                            
                            
                            />}</td>
                            <td>
                                <Link to={`/carsEdit_Monument/`+ cars.id} className='btn btn-primary btn-sm me-2'>edit</Link>
                                <button onClick={() => handleDelete(cars.id)} className='btn btn-sm btn-danger'>delete</button>
                            </td>
                        </tr>
                    })}
                </tbody>
             </table>
        </div>
        
    </div>
  );
}

export default CarMonument;