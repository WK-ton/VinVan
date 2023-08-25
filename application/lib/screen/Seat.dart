import 'package:application/screen/Step.dart';
import 'package:flutter/material.dart';
import 'package:book_my_seat/book_my_seat.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Seat extends StatefulWidget {
  const Seat({
    required this.number,
    required this.fromStation,
    required this.toStation,
    required this.time,
    required this.road,
    required this.token,
  });

  final String number;
  final String fromStation;
  final String toStation;
  final String time;
  final String road;
  final String token;
  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  Set<String> selectedSeats = {};

  final List<String> row1Names = ['A'];
  final List<String> row2Names = ['B'];
  final List<String> row3Names = ['C'];
  final List<String> row4Names = ['D'];
  final List<String> row5Names = ['E'];

  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM/yy');
    return formatter.format(now);
  }

  double calculateTotalPrice(int seatCount, double pricePerSeat) {
    return seatCount * pricePerSeat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 390,
            height: 843,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFFF2F4F8)),
          ),
          Container(
            width: 390,
            height: 300,
            decoration: ShapeDecoration(
              color: Color(0xFF5C24D4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
              ),
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "โปรดเลือกที่นั่ง",
                      style: GoogleFonts.notoSansThai(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                width: 350,
                height: 80,
                decoration: ShapeDecoration(
                  color: Color(0xFF262626),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // จัดให้ Text สาย 999 อยู่ซ้ายสุด
                        children: [
                          Text(
                            '${widget.fromStation} - ${widget.toStation}',
                            style: GoogleFonts.notoSansThai(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'สาย : ${widget.number}',
                            style: GoogleFonts.notoSansThai(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'วันที่ ${getCurrentDate()}',
                            style: GoogleFonts.notoSansThai(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'เวลา : ${widget.time}',
                            style: GoogleFonts.notoSansThai(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 45),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            'assets/sold.png', // Replace 'your_image.png' with your actual image path
                            fit: BoxFit
                                .cover, // You can adjust the fit as needed
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'ที่นั่งเต็ม',
                          style: GoogleFonts.notoSansThai(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            'assets/selected.png', // Replace 'your_image.png' with your actual image path
                            fit: BoxFit
                                .cover, // You can adjust the fit as needed
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('กำลังเลือก', style: GoogleFonts.notoSansThai())
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            'assets/unselected.png', // Replace 'your_image.png' with your actual image path
                            fit: BoxFit
                                .cover, // You can adjust the fit as needed
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'ที่นั่งว่าง',
                          style: GoogleFonts.notoSansThai(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                      ),
                      color: Colors.white,
                      // boxShadow: const [
                      //   BoxShadow(
                      //     blurRadius: 3.5,
                      //     spreadRadius: 1.5,
                      //     color: Color.fromARGB(255, 179, 179, 179),
                      //   )
                      // ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 30),
                      child: Column(
                        children: [
                          Flexible(
                            child: Container(
                              // width: 150,
                              // height: 150,
                              child: SeatLayoutWidget(
                                onSeatStateChanged: (rowI, colI, seatState) {
                                  setState(() {
                                    String seatKey =
                                        '${row1Names[rowI]}${colI + 1}';
                                    if (seatState == SeatState.selected) {
                                      if (selectedSeats.length >= 5) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('เกินข้อผิดพลาด'),
                                                content: Text(
                                                    'คุณเลือกที่นั่งเกิน 5 ที่นั่ง'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('ตกลง'),
                                                  )
                                                ],
                                              );
                                            });
                                        return;
                                      }
                                      selectedSeats.add(seatKey);
                                    } else {
                                      selectedSeats.remove(seatKey);
                                    }
                                  });
                                },
                                stateModel: SeatLayoutStateModel(
                                    rows: 1,
                                    cols: 1,
                                    seatSvgSize: 40,
                                    pathSelectedSeat: 'assets/selected.svg',
                                    pathDisabledSeat: 'assets/disabled.svg',
                                    pathSoldSeat: 'assets/sold.svg',
                                    pathUnSelectedSeat: 'assets/unselected.svg',
                                    currentSeatsState: [
                                      [
                                        SeatState.unselected,
                                      ],
                                    ]),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              // width: 150,
                              // height: 150,
                              child: SeatLayoutWidget(
                                onSeatStateChanged: (rowI, colI, seatState) {
                                  setState(() {
                                    if (seatState == SeatState.selected) {
                                      if (selectedSeats.length >= 5) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('เกินข้อผิดพลาด'),
                                                content: Text(
                                                    'คุณเลือกที่นั่งเกิน 5 ที่นั่ง'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('ตกลง'),
                                                  )
                                                ],
                                              );
                                            });
                                        return;
                                      }
                                      selectedSeats
                                          .add('${row2Names[rowI]}${colI + 1}');
                                    } else {
                                      selectedSeats.remove(
                                          '${row2Names[rowI]}${colI + 1}');
                                    }
                                  });
                                },
                                stateModel: const SeatLayoutStateModel(
                                  rows: 1,
                                  cols: 3,
                                  seatSvgSize: 40,
                                  pathSelectedSeat: 'assets/selected.svg',
                                  pathDisabledSeat: 'assets/disabled.svg',
                                  pathSoldSeat: 'assets/sold.svg',
                                  pathUnSelectedSeat: 'assets/unselected.svg',
                                  currentSeatsState: [
                                    [
                                      SeatState.unselected,
                                      SeatState.unselected,
                                      SeatState.unselected,
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              // width: 150,
                              // height: 150,
                              child: SeatLayoutWidget(
                                onSeatStateChanged: (rowI, colI, seatState) {
                                  setState(() {
                                    if (seatState == SeatState.selected) {
                                      if (selectedSeats.length >= 5) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('เกินข้อผิดพลาด'),
                                                content: Text(
                                                    'คุณเลือกที่นั่งเกิน 5 ที่นั่ง'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('ตกลง'),
                                                  )
                                                ],
                                              );
                                            });
                                        return;
                                      }
                                      selectedSeats
                                          .add('${row3Names[rowI]}${colI + 1}');
                                    } else {
                                      selectedSeats.remove(
                                          '${row3Names[rowI]}${colI + 1}');
                                    }
                                  });
                                },
                                stateModel: const SeatLayoutStateModel(
                                  rows: 1,
                                  cols: 3,
                                  seatSvgSize: 40,
                                  pathSelectedSeat: 'assets/selected.svg',
                                  pathDisabledSeat: 'assets/disabled.svg',
                                  pathSoldSeat: 'assets/sold.svg',
                                  pathUnSelectedSeat: 'assets/unselected.svg',
                                  currentSeatsState: [
                                    [
                                      SeatState.unselected,
                                      SeatState.unselected,
                                      SeatState.unselected,
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              // width: 150,
                              // height: 150,
                              child: SeatLayoutWidget(
                                onSeatStateChanged: (rowI, colI, seatState) {
                                  setState(
                                    () {
                                      if (seatState == SeatState.selected) {
                                        if (selectedSeats.length >= 5) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('เกินข้อผิดพลาด'),
                                                  content: Text(
                                                      'คุณเลือกที่นั่งเกิน 5 ที่นั่ง'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('ตกลง'),
                                                    )
                                                  ],
                                                );
                                              });
                                          return;
                                        }
                                        selectedSeats.add(
                                            '${row4Names[rowI]}${colI + 1}');
                                      } else {
                                        selectedSeats.remove(
                                            '${row4Names[rowI]}${colI + 1}');
                                      }
                                    },
                                  );
                                },
                                stateModel: const SeatLayoutStateModel(
                                  rows: 1,
                                  cols: 3,
                                  seatSvgSize: 40,
                                  pathSelectedSeat: 'assets/selected.svg',
                                  pathDisabledSeat: 'assets/disabled.svg',
                                  pathSoldSeat: 'assets/sold.svg',
                                  pathUnSelectedSeat: 'assets/unselected.svg',
                                  currentSeatsState: [
                                    [
                                      SeatState.unselected,
                                      SeatState.unselected,
                                      SeatState.unselected,
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              // width: 150,
                              // height: 150,
                              child: SeatLayoutWidget(
                                onSeatStateChanged: (rowI, colI, seatState) {
                                  setState(() {
                                    if (seatState == SeatState.selected) {
                                      if (selectedSeats.length >= 5) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('เกินข้อผิดพลาด'),
                                                content: Text(
                                                    'คุณเลือกที่นั่งเกิน 5 ที่นั่ง'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('ตกลง'),
                                                  )
                                                ],
                                              );
                                            });
                                        return;
                                      }
                                      selectedSeats
                                          .add('${row5Names[rowI]}${colI + 1}');
                                    } else {
                                      selectedSeats.remove(
                                          '${row5Names[rowI]}${colI + 1}');
                                    }
                                  });
                                },
                                stateModel: const SeatLayoutStateModel(
                                  rows: 1,
                                  cols: 3,
                                  seatSvgSize: 40,
                                  pathSelectedSeat: 'assets/selected.svg',
                                  pathDisabledSeat: 'assets/disabled.svg',
                                  pathSoldSeat: 'assets/sold.svg',
                                  pathUnSelectedSeat: 'assets/unselected.svg',
                                  currentSeatsState: [
                                    [
                                      SeatState.unselected,
                                      SeatState.unselected,
                                      SeatState.unselected,
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 390,
                    height: 110,
                    decoration: ShapeDecoration(
                      color: Color(0xFF5C24D4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 170,
                          height: 70,
                          decoration: ShapeDecoration(
                            color: Color(0xFF262626),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'เลือกที่นั่ง: ${selectedSeats.join(",")}',
                                  style: GoogleFonts.notoSansThai(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'รวมเงิน: ${calculateTotalPrice(selectedSeats.length, 30)} บาท',
                                  style: GoogleFonts.notoSansThai(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 140,
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    child: StepBooking(
                                      number: widget.number,
                                      fromStation: widget.fromStation,
                                      toStation: widget.toStation,
                                      time: widget.time,
                                      date: getCurrentDate(),
                                      road: widget.road,
                                      selectedSeats: selectedSeats.toList(),
                                      token: widget.token,
                                      
                                    ),
                                    type: PageTransitionType.rightToLeft),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Confirm',
                              style: GoogleFonts.notoSans(
                                color: Colors
                                    .black, // You can customize the text color here
                                fontSize:
                                    16, // You can adjust the font size here
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
