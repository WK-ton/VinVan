import 'package:application/screen/Step.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class SeatReservationScreen extends StatefulWidget {
  final String number;
  final String fromStation;
  final String toStation;
  final String time;
  final String road;
  final String token;

  SeatReservationScreen({
    required this.number,
    required this.fromStation,
    required this.toStation,
    required this.time,
    required this.road,
    required this.token,
  });

  @override
  _SeatReservationScreenState createState() => _SeatReservationScreenState();
}

class _SeatReservationScreenState extends State<SeatReservationScreen> {
  List<List<bool>> seats =
      List.generate(4, (_) => List.generate(3, (_) => false));
  List<List<bool>> reservedSeats =
      List.generate(4, (_) => List.generate(3, (_) => false));

  void _toggleSeat(int row, int col) {
    setState(() {
      if (!reservedSeats[row][col]) {
        if (!seats[row][col]) {
          // If the seat is not already selected, check if any other seat is selected
          bool anySeatSelected = false;
          for (int i = 0; i < seats.length && !anySeatSelected; i++) {
            for (int j = 0; j < seats[i].length && !anySeatSelected; j++) {
              if (seats[i][j]) {
                anySeatSelected = true;
              }
            }
          }
          if (anySeatSelected) {
            // If any seat is already selected, show an alert and return
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('You can only select one seat.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
            return;
          }
        }
        seats[row][col] = !seats[row][col];
        selectedRow = row;
        selectedCol = col;
      }
    });
  }

  String formatSelectedSeats() {
    List<String> formattedSeats = [];
    for (int row = 0; row < seats.length; row++) {
      for (int col = 0; col < seats[row].length; col++) {
        if (seats[row][col]) {
          formattedSeats.add(getSeatLabel(row, col));
        }
      }
    }
    return formattedSeats.join(', '); // Join seats with a comma and space
  }

  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM/yy');
    return formatter.format(now);
  }

  int calculateTotalCost() {
    // Calculate the total cost based on the number of selected seats
    int numberOfSelectedSeats = 0;
    for (int row = 0; row < seats.length; row++) {
      for (int col = 0; col < seats[row].length; col++) {
        if (seats[row][col]) {
          numberOfSelectedSeats++;
        }
      }
    }
    return numberOfSelectedSeats * 30; // 30 baht per seat
  }

  int selectedRow = -1;
  int selectedCol = -1;

  Future<void> fetchReservedSeats() async {
    final url = Uri.parse(
        'http://localhost:8081/booking/api/getSeats'); // แก้ไข URL ตาม URL ของ API ของคุณ

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          for (final reservation in data) {
            final row = reservation['row'];
            final col = reservation['col'];
            final fromstation = reservation['fromstation'];
            final tostation = reservation['tostation'];
            final time = reservation['time'];
            final date = reservation['date'];

            // เพิ่มเงื่อนไขเช็คข้อมูลตรงกับค่าที่รับมาจากคอนสตรักเตอร์
            if (fromstation == widget.fromStation &&
                tostation == widget.toStation &&
                time == widget.time &&
                date == getCurrentDate()) {
              reservedSeats[row][col] = true;
            }
          }
        });
      } else {
        // แสดงข้อความหรือแจ้งเตือนในกรณีที่ไม่สามารถดึงข้อมูลการจองได้
        print('ไม่สามารถดึงข้อมูลการจอง: ${response.statusCode}');
      }
    } catch (error) {
      // แสดงข้อความหรือแจ้งเตือนในกรณีที่มีข้อผิดพลาดในการเชื่อมต่อ
      print('เกิดข้อผิดพลาดในการเชื่อมต่อ: $error');
    }
  }

  String getSeatLabel(int row, int col) {
    List<String> rowLabels = ['A', 'B', 'C', 'D'];

    row = row.clamp(0, rowLabels.length - 1);

    row++;

    col++;

    return '${rowLabels[row - 1]}$col';
  }

  @override
  void initState() {
    super.initState();
    fetchReservedSeats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Reservation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Select your seats:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: List.generate(
                  seats.length,
                  (row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        seats[row].length,
                        (col) {
                          return GestureDetector(
                            onTap: () {
                              _toggleSeat(row, col);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: seats[row][col]
                                    ? Colors.green
                                    : reservedSeats[row][col]
                                        ? Colors.red
                                        : Colors.grey,
                                border: Border.all(color: Colors.black),
                              ),
                              child: Center(
                                child: Text(
                                  getSeatLabel(row, col),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (seats.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Please select at least 1 seat.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }
                final totalCost = calculateTotalCost();
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
                        selectedSeats: formatSelectedSeats(),
                        token: widget.token,
                        selectedRow: selectedRow,
                        selectedCol: selectedCol,
                        totalCost: totalCost, // Pass total cost here
                      ),
                      type: PageTransitionType.rightToLeft),
                );
              },
              child: Text('Reserve Seats'),
            ),
          ],
        ),
      ),
    );
  }
}
