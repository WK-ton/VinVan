import 'package:application/screen/Seat.dart';
import 'package:application/screen/seat_booking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:page_transition/page_transition.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:google_fonts/google_fonts.dart';

class ListCars extends StatefulWidget {
  final String fromStation;
  final String toStation;
  final String time;

  const ListCars(
      {required this.fromStation,
      required this.toStation,
      required this.time,
      Key? key})
      : super(key: key);

  @override
  State<ListCars> createState() => _ListCarsState();
}

class _ListCarsState extends State<ListCars> {
  List<dynamic> cars = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllCars();
  }

  Future<void> fetchAllCars() async {
    await Future.delayed(Duration(seconds: 1));

    final api1Url = 'http://localhost:8081/carBangkhen/getCars/cars_bangkhen';
    final api2Url = 'http://localhost:8081/carMonument/getCars/cars_monument';

    final api1Response = await http.get(Uri.parse(api1Url));
    final api2Response = await http.get(Uri.parse(api2Url));

    final api1Body = api1Response.body;
    final api2Body = api2Response.body;

    final api1Json = jsonDecode(api1Body);
    final api2Json = jsonDecode(api2Body);

    final api1Cars = api1Json['Result'];
    final api2Cars = api2Json['Result'];

    final allCars = [...api1Cars, ...api2Cars];

    cars = allCars.where((car) {
      return car['fromstation'] == widget.fromStation &&
          car['tostation'] == widget.toStation &&
          car['time'] == widget.time;
    }).toList();

    setState(() {
      isLoading = false;
      cars = cars;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ปิด',
                  style: GoogleFonts.notoSansThai(),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
                child: Text(
                  'ผลการค้นหา',
                  style: GoogleFonts.notoSansThai(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            style: GoogleFonts.notoSansThai(color: Colors.indigo),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search",
                suffixIcon: const Icon(Icons.search_outlined),
                prefixIconColor: Colors.indigo),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    //scrollDirection: Axis.horizontal,
                    itemCount: cars.length,
                    itemBuilder: (context, index) {
                      final car = cars[index];
                      final fromstation = car['fromstation'];
                      final tostation = car['tostation'];
                      final number = car['number'];
                      final road = car['road'];
                      final time = car['time'];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 2.0,
                                spreadRadius: 1.5,
                                color: Colors.indigoAccent)
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  child: Seat(
                                    number: number,
                                    fromStation: fromstation,
                                    toStation: tostation,
                                    time: time,
                                  ),
                                  type: PageTransitionType.rightToLeft),
                            );
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'สถานี: $fromstation - $tostation',
                                        style: GoogleFonts.notoSansThai(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'สาย : $number',
                                          style: GoogleFonts.notoSansThai(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        children: [
                                          Text(
                                            'เส้นทางที่ผ่าน: ',
                                            style: GoogleFonts.notoSansThai(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width:
                                                150, // Adjust the width as needed
                                            child: ExpandableText(
                                              road,
                                              style: GoogleFonts.notoSansThai(
                                                  fontSize: 15),
                                              expandText: 'See more',
                                              collapseText: 'See less',
                                              maxLines:
                                                  2, // Limit to 2 lines initially
                                              linkColor: Colors
                                                  .blue, // Optional: Customize link color
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        time,
                                        style: GoogleFonts.notoSans(),
                                      ),
                                      const Icon(Icons.navigate_next_outlined),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Text(
                                          "Ticket",
                                          style: GoogleFonts.notoSans(),
                                        ),
                                      ),
                                      //Text("Dearm")
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ]),
      )),
    );
  }
}
