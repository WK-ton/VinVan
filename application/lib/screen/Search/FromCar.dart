import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FromCar extends StatefulWidget {
  const FromCar({super.key});

  @override
  State<FromCar> createState() => _FromCarState();
}

class _FromCarState extends State<FromCar> {
  List<dynamic> cars = [];

  @override
  void initState() {
    super.initState();
    fetchStation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ปิด',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                    child: Text(
                      'สถานีต้นทาง',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.indigo),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search",
                    suffixIcon: Icon(Icons.search_outlined),
                    prefixIconColor: Colors.indigo),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    final station = car['fromstation'];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, station);
                                },
                                child: Text(
                                  'สถานีขนส่ง: $station',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void fetchStation() async {
    const url = 'http://localhost:8081/carBangkhen/getCars/cars_bangkhen';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    final monumentCars = json['Result'];
    for (final car in monumentCars) {
      final station = car['tostation'];
      if (!cars.any((car) => car['tostation'] == station)) {
        cars.add(car);
      }
    }
    setState(() {
      cars = cars;
    });
  }
}
