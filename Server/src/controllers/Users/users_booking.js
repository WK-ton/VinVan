const con = require("../../config/Database");
const QRCode = require('qrcode');
const generatePayload = require('promptpay-qr');
const _ = require('lodash');

exports.booking_cars = (req, res) => {
    const sql = "INSERT INTO booking (`fromstation`,`tostation`, `number`, `seat`, `name`, `email`, `phone`, `date`, `time`, `road`, `amount`) VALUES (?)";
    const values = [
      req.body.fromstation,
      req.body.tostation,
      req.body.number,
      req.body.seat,
      req.body.name,
      req.body.email,
      req.body.phone,
      req.body.date,
      req.body.time,
      req.body.road,
      req.body.amount
    ];
    con.query(sql,[values], async (err, result) => {
      if (err) {
        return res.json({ Error: 'Error booking car' });
      }     
      return res.json({ Status: 'Success' });
    });
  };

exports.booking_users = (req, res) => {
  const id = req.params.id;
  const sql = "SELECT * FROM booking WHERE id = ?";
  con.query(sql, [id], (err, result) => {
    if (err) {
      return res.json({ status: "Error", message: "Failed to retrieve user data" });
    }

    if (result.length === 0) {
      return res.json({ status: "Error", message: "User not found" });
    }

    return res.json({ status: "Success", data: result, });
  });
}

exports.qrCode = (req, res) => {
  const amount = parseFloat(_.get(req, ["body", "amount"]));
  const mobileNumber = '0969404583';
  const payload = generatePayload(mobileNumber, {amount});

  const option = {
    color: {
      dark: '#000',
      light: '#fff'
    }
  }
  QRCode.toDataURL(payload, option,(err,url) => {
    if(err) {
      console.log('generate fail')
      return res.status(400).json({
        RespCode: 400,
        RespMessage: 'bad : ' + err
      })
    }
    else {
      return res.status(200).json({
        RespCode: 200,
        RespMessage: 'good',
        Result: url
      })
    }
  })
}

