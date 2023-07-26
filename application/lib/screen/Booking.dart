// import 'package:application/Auth/MainLogin.dart';
// import 'package:application/screen/Home.dart';
// import 'package:application/screen/seat_booking.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:expandable_text/expandable_text.dart';
// import 'package:page_transition/page_transition.dart';

// class Booking extends StatefulWidget {
//   const Booking({super.key});

//   @override
//   State<Booking> createState() => _BookingState();
// }

// class _BookingState extends State<Booking> {
//   //List<String> province = ['978', '998', '999'];
//   List<dynamic> cars = [];

//   String? selectedProvinces;

//   @override
//   void initState() {
//     super.initState();
//     fetchCars();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         leading: const Icon(
//           Icons.home_repair_service_sharp,
//           //color: Colors.black,
//         ),
//         backgroundColor: Colors.indigoAccent,
//         //titleTextStyle: const TextStyle(
//         // color: Color.fromARGB(255, 12, 12, 12), fontSize: 18),
//         //title: const Text('Booking'),
//         //shadowColor: Colors.white,
//       ),
//       body: Column(
//         children: [
//           // Container(
//           //   padding: const EdgeInsets.all(8.0),
//           //   margin: const EdgeInsets.all(8.0),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           //     children: province.map((provin) {
//           //       return FilterChip(
//           //         selected: selectedProvinces == provin,
//           //         label: Text(provin),
//           //         onSelected: (selected) {
//           //           setState(() {
//           //             if (selected) {
//           //               selectedProvinces = provin;
//           //               fetchCars();
//           //             } else {
//           //               selectedProvinces = null;
//           //               fetchCars();
//           //             }
//           //           });
//           //         },
//           //       );
//           //     }).toList(),
//           //   ),
//           // ),
//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   height: 565,
//                   padding: const EdgeInsets.all(8),
//                   //margin: const EdgeInsets.only(top: 50),
//                   child: ListView.builder(
//                     itemCount: cars.length,
//                     itemBuilder: (context, index) {
//                       final car = cars[index];
//                       final station = car['fromstation'];
//                       final number = car['number'];
//                       final road = car['road'];
//                       final imageURL = car['image'];
//                       return Container(
//                         margin: const EdgeInsets.symmetric(vertical: 10),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15.0),
//                             color: Colors.white,
//                             boxShadow: [
//                               const BoxShadow(
//                                   blurRadius: 2.0,
//                                   spreadRadius: 1.5,
//                                   color: Colors.indigoAccent)
//                             ]),
//                         padding: const EdgeInsets.all(20),
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               PageTransition(
//                                   child: VanSeat(
//                                       number: number, station: station),
//                                   type: PageTransitionType.rightToLeft),
//                             );
//                           },
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'สถานีขนส่ง: $station',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 8),
//                                         child: Text(
//                                           'สาย : $number',
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ),
//                                       Wrap(
//                                         crossAxisAlignment:
//                                             WrapCrossAlignment.start,
//                                         children: [
//                                           const Text(
//                                             'เส้นทางที่ผ่าน: ',
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           SizedBox(
//                                             width:
//                                                 150, // Adjust the width as needed
//                                             child: ExpandableText(
//                                               road,
//                                               style:
//                                                   const TextStyle(fontSize: 15),
//                                               expandText: 'See more',
//                                               collapseText: 'See less',
//                                               maxLines:
//                                                   2, // Limit to 2 lines initially
//                                               linkColor: Colors
//                                                   .blue, // Optional: Customize link color
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   const Column(
//                                     //crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Icon(Icons.navigate_next_outlined),
//                                       Padding(
//                                         padding:
//                                             EdgeInsets.symmetric(vertical: 8),
//                                         child: Text("Ticket"),
//                                       ),
//                                       //Text("Dearm")
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void fetchCars() async {
//     const url = 'http://localhost:8081/car/getCars';
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);
//     final body = response.body;
//     final json = jsonDecode(body);
//     setState(() {
//       cars = json['Result'];
//     });
//   }
// }
