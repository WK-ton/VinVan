import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class toCar extends StatefulWidget {
  const toCar({super.key});

  @override
  State<toCar> createState() => _toState();
}

class _toState extends State<toCar> {
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
                    final station = car['tostation'];
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
    const url = 'http://localhost:8081/car/getCars';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      cars = json['Result'];
    });
  }
}
