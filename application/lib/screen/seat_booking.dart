// import 'package:application/components/Bottom_tap.dart';
// import 'package:application/screen/Booking.dart';
// import 'package:application/screen/Step.dart';
// import 'package:book_my_seat/book_my_seat.dart';
// import 'package:flutter/material.dart';

// class VanSeat extends StatefulWidget {
//   const VanSeat(
//       {required this.number,
//       required this.fromStation,
//       required this.toStation});

//   final String number;
//   final String fromStation;
//   final String toStation;

//   @override
//   State<VanSeat> createState() => _VanSeatState();
// }

// class _VanSeatState extends State<VanSeat> {
//   Set<String> selectedSeats = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Booking',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             {
//               Navigator.pop(context);
//             }
//           },
//           icon: const Icon(Icons.arrow_back),
//           color: const Color.fromARGB(255, 0, 0, 0),
//         ),
//         backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 16),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Van Number: ${widget.number}',
//                     style: const TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'Station: ${widget.fromStation} - ${widget.toStation}',
//                     style: const TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 32,
//             ),
//             Flexible(
//               child: Container(
//                 margin: const EdgeInsets.fromLTRB(130, 50, 0, 0),
//                 width: double.maxFinite,
//                 height: double.maxFinite,
//                 child: SeatLayoutWidget(
//                   onSeatStateChanged: (rowI, colI, seatState) {
//                     setState(() {
//                       if (seatState == SeatState.selected) {
//                         selectedSeats.add('$rowI-$colI');
//                       } else {
//                         selectedSeats.remove('$rowI-$colI');
//                       }
//                     });
//                   },
//                   stateModel: const SeatLayoutStateModel(
//                     rows: 1,
//                     cols: 3,
//                     seatSvgSize: 50,
//                     pathSelectedSeat: 'assets/selected.svg',
//                     pathDisabledSeat: 'assets/disabled.svg',
//                     pathSoldSeat: 'assets/sold.svg',
//                     pathUnSelectedSeat: 'assets/unselected.svg',
//                     currentSeatsState: [
//                       [
//                         SeatState.unselected,
//                         SeatState.unselected,
//                         SeatState.unselected,
//                         SeatState.unselected,
//                         SeatState.unselected,
//                         SeatState.unselected,
//                         SeatState.unselected,
//                       ],
//                       // [
//                       //   SeatState.unselected,
//                       //   SeatState.unselected,
//                       //   SeatState.empty,
//                       //   SeatState.empty,
//                       //   SeatState.empty,
//                       //   SeatState.empty,
//                       //   SeatState.empty,
//                       // ],
//                       // [
//                       //   SeatState.unselected,
//                       //   SeatState.unselected,
//                       //   SeatState.empty,
//                       //   SeatState.empty,
//                       //   SeatState.empty,
//                       //   SeatState.empty,
//                       //   SeatState.empty,
//                       // ],
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 15,
//                         height: 15,
//                         color: Colors.black,
//                       ),
//                       const SizedBox(width: 2),
//                       const Text('Disabled')
//                     ],
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 15,
//                         height: 15,
//                         color: Colors.red,
//                       ),
//                       const SizedBox(width: 2),
//                       const Text('Sold')
//                     ],
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 15,
//                         height: 15,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black)),
//                       ),
//                       const SizedBox(width: 2),
//                       const Text('Available')
//                     ],
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 15,
//                         height: 15,
//                         color: const Color(0xff0FFF50),
//                       ),
//                       const SizedBox(width: 2),
//                       const Text('Selected by you')
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => StepBooking(
//                       selectedSeats: selectedSeats.toList(),
//                     ),
//                   ),
//                 );
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.resolveWith(
//                     (states) => const Color(0xFFfc4c4e)),
//               ),
//               child: const Text('Buy Tickets'),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               selectedSeats.join(" , "),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
