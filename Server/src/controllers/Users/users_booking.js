const con = require("../../config/Database");

exports.booking_cars = (req, res) => {
    const sql = "INSERT INTO booking (`fromstation`,`tostation`, `number`, `seat`, `name`, `email`, `phone`, `date`, `time`, `road`) VALUES (?)";
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
      req.body.road
    ];
    con.query(sql,[values], (err, result) => {
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