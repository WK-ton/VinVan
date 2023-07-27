const con = require("../../config/Database");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

exports.getItem = (req,res) => {
  res.send("Hello world");
};


exports.userLogin = (req, res) => {
  const email = req.body.email;
  const password = req.body.password;

  if (!email || !password) {
    return res.send(
      JSON.stringify({
        success: false,
        message: "Email and password are required",
      })
    );
  }
  const getUser = "SELECT * FROM User WHERE email = ?";
  con.query(getUser, [email], function (error, results) {
    if (error) {
      return res.send(JSON.stringify({ success: false, message: error }));
    }
    if (results.length === 0) {
      return res.send(
        JSON.stringify({ success: false, message: "Email not found" })
      );
    }
    const user = results[0];

    bcrypt.compare(password, user.password, function (error, passwordMatch) {
      if (error) {
        return res.send(JSON.stringify({ success: false, message: error }));
      }

      if (!passwordMatch) {
        return res.send(
          JSON.stringify({ success: false, message: "Password not found" })
        );
      }
      const token = jwt.sign({ userId: user.id, name: user.name, email: user.email, phone: user.phone }, "secret-key", {
        expiresIn: "10h",
      });

      res.send(
        JSON.stringify({ success: true, message: "Login successful", token, userId: user.id, name: user.name, email: user.email, phone: user.phone })
      );
    });
  });
};


exports.signUp = (req, res) => {
  const name = req.body.name;
  const email = req.body.email;
  const password = req.body.password;
  const password_repeat = req.body.password_repeat;
  const phone = req.body.phone;

  const nameRegex = /^[A-Za-z\s]+$/;
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  const phoneRegex = /^\d{10}$/;

  if (!name || !name.match(nameRegex)) {
    return res.send(
      JSON.stringify({ success: false, message: "Invalid name" })
    );
  }
  if (!email || !email.match(emailRegex)) {
    return res.send(
      JSON.stringify({ success: false, message: "Invalid email" })
    );
  }
  if (password !== password_repeat) {
    return res.send(
      JSON.stringify({ success: false, message: "Passwords do not match" })
    );
  }
  if (!phone || !phone.match(phoneRegex)) {
    return res.send(
      JSON.stringify({
        success: false,
        message: "Invalid phone number. It should be a 10-digit number",
      })
    );
  }

  const checkDuplicate =
    "SELECT * FROM User WHERE name = ? OR email = ? OR phone = ?";
  con.query(checkDuplicate, [name, email, phone], function (error, results) {
    if (error) {
      return res.send(JSON.stringify({ success: false, message: error }));
    }
    if (results.length > 0) {
      const duplicateFields = results.reduce((fields, row) => {
        if (row.name === name) {
          fields.name = true;
        }
        if (row.email === email) {
          fields.email = true;
        }
        if (row.phone === phone) {
          fields.phone = true;
        }
        return fields;
      }, {});
      const duplicateFieldsMessage = Object.keys(duplicateFields).join(",");

      return res.send(
        JSON.stringify({
          success: false,
          message: `ข้อมูลซ้ำกัน: ${duplicateFieldsMessage}`,
        })
      );
    }
    const sql =
      "INSERT INTO User(name, email, password, password_repeat, phone) VALUES (?,?,?,?,?)";
    bcrypt.hash(password, 8, function (error, hashPassword) {
      if (error) {
        res.send(JSON.stringify({ success: false, message: error }));
      } else {
        con.query(
          sql,
          [name, email, hashPassword, hashPassword, phone],
          function (error, data, fields) {
            if (error) {
              res.send(JSON.stringify({ success: false, message: error }));
            } else {
              res.send(JSON.stringify({ success: true, message: "register" }));
            }
          }
        );
      }
    });
  });
};

exports.getUsers = (req, res) => {
  const id = req.params.id;
  const sql = "SELECT name FROM User WHERE id = ?";
  con.query(sql, [id], (err, result) => {
    if (err) {
      return res.json({ status: "Error", message: "Failed to retrieve user data" });
    }

    if (result.length === 0) {
      return res.json({ status: "Error", message: "User not found" });
    }

    const name = result[0].name;

    return res.json({ status: "Success", name: name, });
  });
};

