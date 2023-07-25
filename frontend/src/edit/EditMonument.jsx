import 'bootstrap/dist/css/bootstrap.min.css';
import { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate, useParams } from 'react-router-dom';

function EditCars_monument() {
    const [data, setData] = useState({
        fromstation: '',
        tostation: '',
        number: '',
        road: '',
        time: '',
        // image:''
        
    })
    const {id} = useParams();
    useEffect(() => {
        axios.get('http://localhost:8081/carMonument/get/cars_monument/'+id)
        .then(res => {
            setData({...data, fromstation: res.data.Result[0].fromstation,
                tostation: res.data.Result[0].tostation,
                number: res.data.Result[0].number,
                road: res.data.Result[0].road,
                time: res.data.Result[0].time,
                // image: res.data.Result[0].image
            })
        })
        .catch(err => console.log(err))
    },[])
    const handleSubmit = (event) => {
        event.preventDefault();
        axios.put('http://localhost:8081/carMonument/update/cars_monument/'+id, data)
        .then(res => {
            if(res.data.Status === 'Success') {
              navigate('/CarsMonument');
            }
         })
        .catch(err=>console.log(err));
    }
    const navigate = useNavigate()
  return (
    <div className='d-flex flex-column align-items-center pt-5'>
        <h2>Update Cars</h2>
            <form className = "row g-3 w-50" onSubmit={handleSubmit}>
                <div className='col-12'>
                    <label  htmlFor ="inputstation" className='form-label'> From Station </label>
                        <input type='text' className='form-control' id='inputName' placeholder='' autoComplete='off'
                        onChange={e=> setData({...data,fromstation: e.target.value})} value={data.fromstation}/>
                </div>
                <div className='col-12'>
                    <label  htmlFor ="inputstation" className='form-label'> To Station </label>
                        <input type='text' className='form-control' id='inputName' placeholder='' autoComplete='off'
                        onChange={e=> setData({...data,tostation: e.target.value})} value={data.tostation}/>
                </div> 
                <div className='col-12'>
                    <label  htmlFor ="inputnumber" className='form-label'> Cars Number </label>
                        <input type='number' className='form-control' id='inputEmail' placeholder='' autoComplete='off'
                        onChange={e=> setData({...data,number: e.target.value})} value={data.number}/>
                </div>        
                <div className='col-12'>
                    <label htmlFor ="inputPassword" className='form-label'> Road Cars </label>
                        <input type='text' className='form-control' id='inputroad' placeholder='' 
                        onChange={e=> setData({...data,road: e.target.value})} value={data.road}/>
                </div> 
                <div className='col-12'>
                    <label htmlFor ="inputPassword" className='form-label'> Time </label>
                        <input type='time' className='form-control' id='inputroad' placeholder='' 
                        onChange={e=> setData({...data,time: e.target.value})} value={data.time}/>
                </div>  
                <div className="col-12">
                <button type= "submit"className='btn btn-primary '> Update </button>
            </div> 
            </form>
            
    </div>
  )
}

export default EditCars_monument