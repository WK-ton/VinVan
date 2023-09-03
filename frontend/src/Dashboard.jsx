import axios from "axios";
import { useEffect, useState } from "react";
import "../src/css/Dashboard.css";
import Nav from "react-bootstrap/Nav";

function Dashboard() {
  const [data, setData] = useState([]);

  const [enlargedId, setEnlargedId] = useState(null);

  const toggleEnlarged = (id) => {
    setEnlargedId(enlargedId === id ? null : id);
  };

  const isEnlarged = (id) => {
    return id === enlargedId;
  };

  const getStatusColor = (acceptValue) => {
    return acceptValue === 0 ? "red" : "green";
  };

  useEffect(() => {
    axios
      .get("http://localhost:8081/booking/get/user")
      .then((res) => {
        if (res.data.status === "Success") {
          setData(res.data.data);
        } else {
          alert("Error");
        }
      })
      .catch((err) => console.log(err));
  }, []);

  const handleDelete = (id) => {
    axios
      .delete("http://localhost:8081/booking/delete/booking/" + id)
      .then((res) => {
        if (res.data.Status === "Success") {
          window.location.reload(true);
        } else {
          alert("Error");
        }
      })
      .catch((err) => console.log(err));
  };

  const updateBoolean = (id) => {
    axios
      .put("http://localhost:8081/booking/update/booking/" + id)
      .then((res) => {
        if (res.data.status === "Success") {
          window.location.reload();
          alert("อนุมัติเรียบร้อย");
        } else {
          alert("Error updating accept value");
        }
      })
      .catch((err) => {
        console.log(err);
        alert("Error updating accept value");
      });
  };

  return (
    <div>
      <Nav className="container" variant="pills">
        <Nav className="active">
          <Nav.Link className="font" href="/">
            HOME
          </Nav.Link>
        </Nav>
        <Nav className="active">
          <Nav.Link className="font" href="/CarsBangKhen">
            CarsBangKhen
          </Nav.Link>
        </Nav>
        <Nav className="active">
          <Nav.Link className="font" href="/CarsMonument">
            CarsMonument
          </Nav.Link>
        </Nav>
        <Nav className="active">
          <Nav.Link className="font" href="/CarSaiTai">
            CarsSaiTai
          </Nav.Link>
        </Nav>
      </Nav>
      <div className="mt-4 px-5 pt-3 text-center">
        <h4>รายการจอง</h4>
        <table className="table">
          <thead>
            <tr className="text-center">
              <th>ID</th>
              <th>สถานีต้นทาง</th>
              <th>สถานีต้นปลายทาง</th>
              <th>เลขรถ</th>
              <th>วันที่</th>
              <th>เวลารถออก</th>
              <th>มัดจำ</th>
              <th>รูป</th>
              <th>วันที่โอน</th>
              <th>เวลา</th>
              <th>ที่นั่ง</th>
            </tr>
          </thead>
          <tbody>
            {data.map((cars, index) => (
              <tr
                key={index}
                className="text-center"
                style={{ backgroundColor: getStatusColor(cars.accept) }}
              >
                <td>{cars.id}</td>
                <td>{cars.fromstation}</td>
                <td>{cars.tostation}</td>
                <td>{cars.number}</td>
                <td>{cars.date}</td>
                <td>{cars.time}</td>
                <td>{cars.amount} บาท</td>
                <td>
                  <img
                    src={`http://localhost:8081/images/${cars.image}`}
                    alt=""
                    className="cars_images"
                    style={
                      isEnlarged(cars.id)
                        ? { width: "300px", height: "500px" }
                        : { width: "100px", height: "100px" }
                    }
                    onClick={() => toggleEnlarged(cars.id)}
                  />
                </td>
                <td>{cars.time_image}</td>
                <td>{cars.date_image}</td>
                <td>{cars.seat}</td>
                <td >
                  <button
                    onClick={() => updateBoolean(cars.id)}
                    className={`btn btn-sm`}
                    style={{ backgroundColor: getStatusColor(cars.accept) }}
                  >
                    {cars.accept === 0 ? "รออนุมัติ" : "อนุมัติ"}
                  </button>
                  <button
                    onClick={() => handleDelete(cars.id)}
                    className="btn btn-sm btn-danger"
                  >
                    delete
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

export default Dashboard;
