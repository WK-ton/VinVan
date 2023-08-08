import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class TimeSelect extends StatefulWidget {
  const TimeSelect({super.key});

  @override
  State<TimeSelect> createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {
  List<dynamic> cars = [];

  @override
  void initState() {
    super.initState();
    fetchCarBangKhen();
    fetchCarMonument();
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
                    child: Text('ปิด',
                        style: GoogleFonts.notoSansThai(
                            fontWeight: FontWeight.w500, color: Colors.indigo)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                    child: Text(
                      'เลือกเวลา',
                      style: GoogleFonts.notoSansThai(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                style: GoogleFonts.notoSansThai(color: Colors.indigo),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 228, 228, 228),
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
                    final time = car['time'];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, time);
                                },
                                child: Text(
                                  'เวลา: $time',
                                  style: GoogleFonts.notoSansThai(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.indigo),
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

  void fetchCarBangKhen() async {
    const url = 'http://localhost:8081/carBangkhen/getCars/cars_bangkhen';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      cars = json['Result'];
    });
  }

  void fetchCarMonument() async {
    const url = 'http://localhost:8081/carMonument/getCars/cars_monument';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      cars.addAll(json['Result']);
    });
  }
}
