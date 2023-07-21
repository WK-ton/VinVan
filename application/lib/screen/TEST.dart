// import 'package:application/components/custom_icon.dart';
// import 'package:application/screen/FromCar.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:page_transition/page_transition.dart';

// class FormBooking extends StatefulWidget {
//   const FormBooking({super.key});

//   @override
//   State<FormBooking> createState() => _FormBookingState();
// }

// class _FormBookingState extends State<FormBooking> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.indigo,
//       body: SafeArea(
//         bottom: false,
//         child: Stack(
//           children: <Widget>[
//             Container(
//               height: double.infinity,
//               margin: EdgeInsets.only(top: size.height * 0.25),
//               color: Colors.white,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(
//                 children: [
//                   _HeaderSection(),
//                   _SearchCard(),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _HeaderSection extends StatelessWidget {
//   const _HeaderSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             CircleAvatar(
//               radius: 25.0,
//               backgroundColor: Colors.black,
//             ),
//             CustomIconButton(
//               icon: Icon(Icons.notifications_active_outlined),
//             ),
//           ],
//         ),
//         Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Text(
//             'Worapong',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 28,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _SearchCard extends StatelessWidget {
//   const _SearchCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //final TextEditingController = TextEditingController();
//     final locationTextController = TextEditingController();
//     final dateFromTextController = TextEditingController();
//     final dateToTextController = TextEditingController();

//     locationTextController.text = 'KUKPS';
//     dateFromTextController.text = dateFromTextController.text =
//         DateFormat('dd MMM yyyy').format(DateTime.now());

//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 20.0,
//         vertical: 10.0,
//       ),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.lightBlue.withAlpha(50))),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Icon(Icons.location_on_outlined, color: Colors.indigo),
//               SizedBox(width: 20.0),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     PageTransition(
//                         child: FromCar(), type: PageTransitionType.rightToLeft),
//                   );
//                 },
//                 child: const Text(
//                   'From',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 //controller: locationTextController,
//               )
//             ],
//           ),
//           const Divider(),
//           Row(
//             children: [
//               Icon(Icons.location_on_outlined, color: Colors.indigo),
//               SizedBox(width: 20.0),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     PageTransition(
//                         child: FromCar(), type: PageTransitionType.bottomToTop),
//                   );
//                 },
//                 child: const Text(
//                   'To',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 //controller: locationTextController,
//               )
//             ],
//           ),
//           const Divider(),
//           Row(
//             children: [
//               Icon(Icons.calendar_month, color: Colors.indigo),
//               SizedBox(width: 20.0),
//               CustomTextField(
//                 onPressed: () {},
//                 label: 'From',
//                 controller: dateFromTextController,
//               ),
//               CustomTextField(
//                 onPressed: () {},
//                 label: 'To',
//                 controller: dateFromTextController,
//               )
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 PageTransition(
//                     child: FromCar(), type: PageTransitionType.bottomToTop),
//               );
//             },
//             style: ButtonStyle(
//               shape: MaterialStateProperty.all(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//               backgroundColor: MaterialStateProperty.all(Colors.indigo),
//               elevation: MaterialStateProperty.all(0.0),
//               minimumSize: MaterialStateProperty.all(const Size(200, 50)),
//             ),
//             child: const Text('Search'),
//           )
//         ],
//       ),
//     );
//   }
// }

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final Function()? onPressed;

//   const CustomTextField({
//     required this.label,
//     required this.controller,
//     required this.onPressed,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           label: Text(label),
//           border: InputBorder.none,
//         ),
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

import 'package:application/components/custom_icon.dart';
import 'package:application/screen/FromCar.dart';
import 'package:application/screen/ToCar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              margin: EdgeInsets.only(top: size.height * 0.25),
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.black,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomIconButton(
                                    icon: Icon(
                                        Icons.notifications_active_outlined),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Worapong',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // _HeaderSection(),
                  // _SearchCard(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.lightBlue.withAlpha(50))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Colors.indigo),
                            SizedBox(width: 20.0),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      child: FromCar(),
                                      type: PageTransitionType.bottomToTop),
                                );
                              },
                              child: const Text(
                                'From',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              //controller: locationTextController,
                            )
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Colors.indigo),
                            SizedBox(width: 20.0),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      child: ToCar(),
                                      type: PageTransitionType.bottomToTop),
                                );
                              },
                              child: const Text(
                                'To',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              //controller: locationTextController,
                            )
                          ],
                        ),
                        // const Divider(),
                        // Row(
                        //   children: [
                        //     Icon(Icons.calendar_month, color: Colors.indigo),
                        //     SizedBox(width: 20.0),
                        //     CustomTextField(
                        //       onPressed: () {},
                        //       label: 'From',
                        //       controller: dateFromTextController,
                        //     ),
                        //     CustomTextField(
                        //       onPressed: () {},
                        //       label: 'To',
                        //       controller: dateFromTextController,
                        //     )
                        //   ],
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  child: FromCar(),
                                  type: PageTransitionType.bottomToTop),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo),
                            elevation: MaterialStateProperty.all(0.0),
                            minimumSize:
                                MaterialStateProperty.all(const Size(200, 50)),
                          ),
                          child: const Text('Search'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
