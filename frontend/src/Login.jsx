import {
  MDBContainer,
  MDBRow,
  MDBCol,
  MDBCard,
  MDBInput,
}
from 'mdb-react-ui-kit';
import { useState } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import './Login.css'
import { useNavigate } from 'react-router-dom';

function Login() {
    const [values, setValues] = useState({
        email: '',
        password: ''
    })
const navigate = useNavigate()
const [error , setError] = useState('');

const handleSubmit = (e) => {
 e.preventDefault();
 axios.post('http://localhost:8081/auth/login' ,values)
 .then(res => {
    if(res.data.Status === 'Success') {
      navigate('/');
    } else {
      setError(res.data.Error);
    }
 })
 .catch(err => console.log(err));
}
  return (
    <MDBContainer fluid>

      <MDBRow className='d-flex justify-content-center align-items-center h-100'>
        <MDBCol col='12'>


          <MDBCard className='bg-dark text-white my-5 mx-auto' style={{borderRadius: '1rem', maxWidth: '400px'}}>
            {/* <MDBCardBody className='p-5 d-flex flex-column align-items-center mx-auto w-100'> */}
            <form  className = "p-5 d-flex flex-column align-items-center mx-auto w-100" onSubmit={handleSubmit} >
            <div className='p-2 rounded w-10 border loginForm color-text'>
            {error && error}
          </div>
              <h2 className="fw-bold mb-2 text-uppercase mb-4">Login</h2>

            
              <MDBInput wrapperClass='mb-4 mx-5 w-100' 
              labelClass='text-white' 
              placeholder='Email address' 
              id='formControlLg' 
              type='email' 
              size="lg" 
              onChange={e => setValues({...values, email: e.target.value})}
              />
              <MDBInput wrapperClass='mb-4 mx-5 w-100' 
              labelClass='text-white'
              placeholder='Password' 
              id='formControlLg' 
              type='password' 
              size="lg"
              onChange={e => setValues({...values, password: e.target.value})}
              />

              <button className='mx-2 px-5 text-black mb-4 color-button' size='lg' > Login </button>
             <div>
                <p className="mb-0">Dont have an account For Admin? <a href="#!" className="text-white-50 fw-bold">Sign Up</a></p>

              </div>
            </form>
            {/* </MDBCardBody> */}
          </MDBCard>

        </MDBCol>
      </MDBRow>

    </MDBContainer>
  );
}

export default Login;