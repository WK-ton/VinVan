const express = require('express');
const cors = require('cors');
const con = require('./src/config/Database');
const cookieParser = require('cookie-parser');
const authRouter = require('./src/routes/authRoutes');
const carsRouter = require('./src/routes/carRoutes');
const app = express();
app.use(cors());
app.use(cookieParser());
app.use(express.json());
app.use(express.static('public'));

let PORT = process.env.PORT || 8081;


con.connect(function(err){
    if(err) {
        console.log("Error in Connection");
    }else {
        console.log("Connected");
    }
})

app.use('/auth', authRouter);
app.use('/car', carsRouter);

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}.`);
  });


