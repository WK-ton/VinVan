const con = require('../../config/Database');
const upload = require('../../middleware/multer');

exports.create = (req, res) => {
      const sql = "INSERT INTO cars (`fromstation`,`tostation`, `number`, `road`, `image`) VALUES (?)";
      const values = [
        req.body.fromstation,
        req.body.tostation,
        req.body.number,
        req.body.road,
        req.file.filename
      ];
      con.query(sql,[values], (err, result) => {
        if (err) {
          return res.json({ Error: 'Error creating car' });
        }
        return res.json({ Status: 'Success' });
      });
    };

// Handle getCars route
exports.getCars = (req, res) => {
    const sql = "SELECT * FROM cars";
    con.query(sql, (err, result) => {
        if (err) return res.json({ Error: "Get Error in sql" });
        return res.json({ Status: "Success", Result: result });
    });
};

// Handle getCarById route
exports.getCarById = (req, res) => {
    const id = req.params.id;
    const sql = "SELECT * FROM cars WHERE id = ?";
    con.query(sql, [id], (err, result) => {
        if (err) return res.json({ Error: "Get cars Error in sql" });
        return res.json({ Status: "Success", Result: result });
    });
};
exports.getCarImage = (req, res) => {
    const sql = "SELECT image FROM cars ";
    con.query(sql, (err, result) => {
        if(err) return res.json({Error: "Error Image"});
        return res.json({Status: "Success Image"})
    })
    const image = result[0].image; // Assuming the image column is named 'image'

    return res.json({ image });
} 
exports.getAllNumber = (req, res) => {
    const sql = "SELECT number FROM cars";
    con.query(sql, (err, result) => {
        if (err) return res.json({ Error: "Get cars Error in sql" });
        return res.json({ Status: "Success", Result: result });
    });
}
exports.getNumber = (req, res) => {
    const {number} = req.query
    let sql = `SELECT *, number as number FROM cars WHERE id = id `

    if (number) {
        let numberFilter = number.join("','")
        sql += `AND number IN('${numberFilter}')` 
    }
    con.query(sql, (err, result) => {
        if (err) {
            return res.json({ Error: "Get cars error in SQL" });
        }

        return res.json({ Status: "Success", Result: result });
    });
}
// Handle updateCar route
exports.updateCar = (req, res) => {
    const id = req.params.id;
    const sql = "UPDATE cars SET fromstation = ?, tostation = ?,number = ?, road = ? WHERE id = ?";
    con.query(sql, [req.body.fromstation,req.body.tostation, req.body.number, req.body.road, id], (err, result) => {
        if (err) return res.json({ Error: "Update cars Error in sql" });
        return res.json({ Status: "Success" });
    });
};

// Handle deleteCar route
exports.deleteCar = (req, res) => {
    const id = req.params.id;
    const sql = "DELETE FROM cars WHERE id = ?";
    con.query(sql, [id], (err, result) => {
        if (err) return res.json({ Error: "Delete cars Error in sql" });
        return res.json({ Status: "Success" });
    });
    con.query('ALTER TABLE cars AUTO_INCREMENT = 0', (error, result, fields) => {
        if (error) {
            console.error("Error", error);
        } else {
            console.log({ Status: 'Reset ID Success' });
        }
    });
};
