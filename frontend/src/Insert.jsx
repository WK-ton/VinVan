import 'bootstrap/dist/css/bootstrap.min.css';
import { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

function Insert() {
    const [data, setData] = useState({
        fromstation: '',
        tostation:'',
        number: '',
        road: '',
        image: ''
    })
    const handleSubmit = (event) => {
        event.preventDefault();
        const formdata = new FormData();
        formdata.append("fromstation", data.fromstation);
        formdata.append("tostation", data.tostation);
        formdata.append("number", data.number);
        formdata.append("road", data.road);
        formdata.append("image", data.image);
        axios.post('http://localhost:8081/car/create', formdata)
        .then(res => {
            if(res.data.Status === 'Success') {
              navigate('/');
            }
         })
        .catch(err=>console.log(err));
    }
    const navigate = useNavigate()
  return (
    <div className='d-flex flex-column align-items-center pt-5'>
        <h2>Add Vans</h2>
            <form className = "row g-3 w-50" onSubmit={handleSubmit}>
                <div className='col-12'>
                    <label  htmlFor ="inputName" className='form-label'> From Station </label>
                        <input type='station' className='form-control' id='inputstation' placeholder='' autoComplete='off'
                        onChange={e=> setData({...data,fromstation: e.target.value})}/>
                </div> 
                <div className='col-12'>
                    <label  htmlFor ="inputName" className='form-label'> To Station </label>
                        <input type='station' className='form-control' id='inputstation' placeholder='' autoComplete='off'
                        onChange={e=> setData({...data,tostation: e.target.value})}/>
                </div> 
                <div className='col-12'>
                    <label  htmlFor ="inputEmail" className='form-label'> Cars Number </label>
                        <input type='number' className='form-control' id='inputnumber' placeholder='' autoComplete='off'
                        onChange={e=> setData({...data,number: e.target.value})}/>
                </div>     
                <div className='col-12'>
                    <label htmlFor ="inputPassword" className='form-label'> Road Cars </label>
                        <input type='road' className='form-control' id='inputroad' placeholder='' autoComplete='off'
                        onChange={e=> setData({...data,road: e.target.value})}/>
                </div>          
                <div className='col-12'>
                    <label htmlFor ="inputFile" className='form-label'> Image Cars </label>
                        <input type='file' className='form-control' id='inputFile' 
                        onChange={e=> setData({...data,image: e.target.files[0]})}/>
                </div>  
                <div className="col-12">
                <button type= "submit"className='btn btn-primary '> Sumbit </button>
            </div> 
            </form>
            
    </div>
  )
}

export default Insert