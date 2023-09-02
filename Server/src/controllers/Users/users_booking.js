const con = require("../../config/Database");
const QRCode = require("qrcode");
const generatePayload = require("promptpay-qr");
const _ = require("lodash");

// exports.booking_cars = (req, res) => {
//   const checksql =
//     "SELECT COUNT(*) AS count FROM booking WHERE `fromstation` = ? AND `tostation` = ? AND `seat` = ? AND `date` = ? AND `time` = ?";
//   const check = [
//     req.body.fromstation,
//     req.body.tostation,
//     req.body.seat,
//     req.body.date,
//     req.body.time,
//   ];

//   con.query(checksql, check, (err, result) => {
//     if (err) {
//       console.error("Error checking existing data:", err);
//       return res.status(500).json({ error: "Error checking existing data" });
//     }

//     if (result[0].count > 0) {
//       return res
//         .status(400)
//         .json({ error: "Data already exists in the system" });
//     }

//     const sql =
//       "INSERT INTO booking (`fromstation`, `tostation`, `number`, `seat`, `name`, `email`, `phone`, `date`, `time`, `road`, `amount`, `image`, `time_image`, `date_image`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//     const values = [
//       req.body.fromstation,
//       req.body.tostation,
//       req.body.number,
//       req.body.seat,
//       req.body.name,
//       req.body.email,
//       req.body.phone,
//       req.body.date,
//       req.body.time,
//       req.body.road = req.body.road.substring(0, 255),
//       req.body.amount,
//       req.file ? req.file.filename : null,
//       req.body.time_image,
//       req.body.date_image,
//     ];

//     con.query(sql, values, (err, result) => {
//       if (err) {
//         console.error("Error creating car:", err);
//         return res.status(500).json({ error: "Error creating car" });
//       }
//       return res.json({ status: "Success" });
//     });
//   });
// };

exports.booking_cars = (req, res) => {
  const checksql =
  `SELECT * FROM booking WHERE fromstation = ? AND tostation = ? AND date = ? AND time = ? AND seat = ?`;
  const check = [
    req.body.fromstation,
    req.body.tostation,
    req.body.date,
    req.body.time,
    req.body.seat
  ];
  con.query(checksql, check, (err, result) => {
    if (err) {
      console.error("เกิดข้อผิดพลาดในการตรวจสอบที่นั่ง:", err);
      return res.status(500).json({ error: "เกิดข้อผิดพลาดในการตรวจสอบที่นั่ง" });
    } else if (result.length > 0) {
      res.status(400).json({error: 'ที่นั่งถูกจองแล้ว'})
    } else {
    const sql =
      "INSERT INTO booking (`fromstation`, `tostation`, `number`, `name`, `email`, `phone`, `date`, `time`, `road`, `amount`, `image`, `time_image`, `date_image`, `row`, `col`, `seat`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    const values = [
      req.body.fromstation,
      req.body.tostation,
      req.body.number,
      req.body.name,
      req.body.email,
      req.body.phone,
      req.body.date,
      req.body.time,
      req.body.road = req.body.road.substring(0, 255),
      req.body.amount,
      req.file ? req.file.filename : null,
      req.body.time_image,
      req.body.date_image,
      req.body.row,
      req.body.col,
      req.body.seat
    ];
    con.query(sql, values, (err, result) => {
      if (err) {
        console.error("เกิดข้อผิดพลาดในการจองที่นั่ง:", err);
        return res.status(500).json({ error: "เกิดข้อผิดพลาดในการจองที่นั่ง" });
      } else {
      console.log('จองที่นั่งเรียบร้อยแล้ว');
      return res.json({ status: "จองที่นั่งเรียบร้อยแล้ว" });
      }
    });
  }
  });
};

exports.checkSeat = (req, res) => {
  const values = [
    req.body.fromstation,
    req.body.tostation,
    req.body.date,
    req.body.time,
    req.body.row,
    req.body.col
    ,
  ];
  const sql =
    "SELECT `fromstation`, `tostation`, `seat`, `date`, `time` , `row`, `col `FROM `booking` WHERE 1";

  con.query(sql, [values], (err, result) => {
    if (err) {
      return res.json({
        status: "Error",
        message: "Failed to retrieve booking data",
      });
    }

    if (result.length === 0) {
      return res.json({
        status: "Error",
        message: "No booking found for the provided stations",
      });
    }

    return res.json({ status: "Success", data: result });
  });
};


exports.booking_users = (req, res) => {
  const id = req.params.id;
  const sql = "SELECT * FROM booking WHERE id = ?";
  con.query(sql, [id], (err, result) => {
    if (err) {
      return res.json({
        status: "Error",
        message: "Failed to retrieve user data",
      });
    }

    if (result.length === 0) {
      return res.json({ status: "Error", message: "User not found" });
    }

    return res.json({ status: "Success", data: result });
  });
};

exports.qrCode = (req, res) => {
  const amount = parseFloat(_.get(req, ["body", "amount"]));
  const mobileNumber = "0969404583";
  const payload = generatePayload(mobileNumber, { amount });

  const option = {
    color: {
      dark: "#000",
      light: "#fff",
    },
  };
  QRCode.toDataURL(payload, option, (err, url) => {
    if (err) {
      console.log("generate fail");
      return res.status(400).json({
        RespCode: 400,
        RespMessage: "bad : " + err,
      });
    } else {
      return res.status(200).json({
        RespCode: 200,
        RespMessage: "good",
        Result: url,
      });
    }
  });
};

exports.reserve = (req, res) => {
  const { row, col } = req.body;

  // เช็คว่าที่นั่งถูกจองหรือไม่
  const checkSeatQuery = `SELECT * FROM seats WHERE row = ? AND col = ? `;
  con.query(checkSeatQuery, [row, col], (err, results) => {
    if (err) {
      console.error('เกิดข้อผิดพลาดในการตรวจสอบที่นั่ง:', err);
      res.status(500).json({ error: 'เกิดข้อผิดพลาดในการตรวจสอบที่นั่ง' });
    } else if (results.length > 0) {
      res.status(400).json({ error: 'ที่นั่งถูกจองแล้ว' });
    } else {
      // ที่นั่งยังไม่ถูกจอง ดังนั้นทำการจอง
      const reserveSeatQuery = `INSERT INTO seats (row, col) VALUES (?, ?)`;
      con.query(reserveSeatQuery, [row, col], (err, results) => {
        if (err) {
          console.error('เกิดข้อผิดพลาดในการจองที่นั่ง:', err);
          res.status(500).json({ error: 'เกิดข้อผิดพลาดในการจองที่นั่ง' });
        } else {
          console.log('จองที่นั่งเรียบร้อยแล้ว');
          res.status(200).json({ message: 'จองที่นั่งเรียบร้อยแล้ว' });
        }
      });
    }
  });
}

exports.getseats = (req, res) => {  
  const query = 'SELECT fromstation, tostation, time , date, row, col FROM booking'; // แก้ไขชื่อตารางและคอลัมน์ตามโครงสร้างของฐานข้อมูลของคุณ
  con.query(query, (err, results) => {
    if (err) {
      console.error('เกิดข้อผิดพลาดในการดึงข้อมูล: ' + err);
      res.status(500).send('เกิดข้อผิดพลาดในการดึงข้อมูล');
      return;
    }
    
    const reservedSeats = results.map((row) => {
      return {
        fromstation: row.fromstation,
        tostation: row.tostation,
        time: row.time,
        date: row.date,
        row: row.row,
        col: row.col,
      };
    });
    
    res.json(reservedSeats);
  });
}

// exports.seat = (req, res) => {
//   try {
//     const [rows] = con.query('SELECT * FROM seats');
//     res.json(rows);
//   } catch (error) {
//     console.error('Error fetching seat data:', error.message);
//     res.status(500).json({ error: 'Internal server error' });
//   }
// }

// // API route to reserve seats
// exports.reserve = (req, res) => {
//   const { seatNumbers } = req.body;
//   try {
//     // Check if seats are available for reservation
//     const [rows] = con.query(
//       'SELECT * FROM seats WHERE seatNumber IN (?) AND isOccupied = false',
//       [seatNumbers]
//     );

//     if (rows.length === seatNumbers.length) {
//       // All selected seats are available; mark them as reserved
//       con.query(
//         'UPDATE seats SET isOccupied = true, isSelected = false WHERE seatNumber IN (?)',
//         [seatNumbers]
//       );

//       res.status(200).json({ message: 'Seats reserved successfully' });
//     } else {
//       res.status(400).json({ error: 'Selected seats are not available' });
//     }
//   } catch (error) {
//     console.error('Error reserving seats:', error.message);
//     res.status(500).json({ error: 'Internal server error' });
//   }
// }

