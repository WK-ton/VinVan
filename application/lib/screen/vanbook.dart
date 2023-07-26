// import 'package:application/screen/seat_booking.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:page_transition/page_transition.dart';

// class vanBooking extends StatefulWidget {
//   const vanBooking({Key? key}) : super(key: key);

//   @override
//   State<vanBooking> createState() => _vanBookingState();
// }

// class _vanBookingState extends State<vanBooking> {
//   List<dynamic> cars = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchCars();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Container(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.only(left: 25.0, top: 45.0, right: 25.0),
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Text(
//                           "Booking",
//                           style: TextStyle(
//                               fontSize: 50, fontWeight: FontWeight.bold),
//                         )
//                       ],
//                     ),
//                     //const SizedBox(height: 20.0),
//                     // Container(
//                     //   height: 40.0,
//                     //   child: ListView(
//                     //     scrollDirection: Axis.horizontal,
//                     //     children: <Widget>[
//                     //       buildTopChip("6.30", true),
//                     //       buildTopChip("7.00", false),
//                     //       buildTopChip("7.30", false),
//                     //       buildTopChip("8.00", false),
//                     //       buildTopChip("8.30", false),
//                     //       buildTopChip("9.00", false),
//                     //     ],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               child: Expanded(
//                   child: ListView.builder(
//                 itemCount: cars.length,
//                 itemBuilder: (context, index) {
//                   final car = cars[index];
//                   final station = car['station'];
//                   final number = car['number'];
//                   //final road = car['road'];
//                   final imageURL = car['image'];
//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           PageTransition(
//                               child:
//                                  VanSeat(number: number, ),
//                               type: PageTransitionType.rightToLeft));
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(vertical: 12.0),
//                       padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                       child: Column(
//                         children: <Widget>[
//                           SizedBox(
//                               height: 200,
//                               child: imageURL != null
//                                   ? ClipRRect(
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(10.0),
//                                         topRight: Radius.circular(10.0),
//                                       ),
//                                       child: Image.network(
//                                         'http://localhost:8081/images/$imageURL',
//                                         fit: BoxFit.cover,
//                                       ),
//                                     )
//                                   : const SizedBox()),
//                           Container(
//                             padding: const EdgeInsets.all(25.0),
//                             decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(10.0),
//                                   bottomRight: Radius.circular(10.0),
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       blurRadius: 2.0,
//                                       spreadRadius: 1.0,
//                                       color: Colors.grey)
//                                 ]),
//                             child: Row(
//                               children: <Widget>[
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Text(
//                                       'สาย: $number',
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16.0),
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text(
//                                       'สถานี: $station',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16.0,
//                                         //color: Colors.grey
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 // CircleAvatar(
//                                 //   backgroundColor: Colors.indigoAccent,
//                                 // )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               )),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Container buildTopChip(String label, bool isActive) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 5.0),
//       child: Chip(
//         padding: EdgeInsets.all(8.0),
//         label: Text(
//           label,
//           style: TextStyle(color: Colors.white, fontSize: 16.0),
//         ),
//         backgroundColor: isActive ? Colors.indigoAccent : Colors.grey,
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
