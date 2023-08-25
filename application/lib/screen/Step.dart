import 'package:application/components/Bottom_tap.dart';
import 'package:application/screen/QR_code.dart';
import 'package:application/screen/Search/Search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mysql1/mysql1.dart';

class StepBooking extends StatefulWidget {
  final List<String> selectedSeats;
  final String number;
  final String fromStation;
  final String toStation;
  final String time;
  final String date;
  final String road;
  final String token;

  StepBooking({
    Key? key,
    required this.selectedSeats,
    required this.number,
    required this.fromStation,
    required this.toStation,
    required this.time,
    required this.date,
    required this.road,
    required this.token,
  }) : super(key: key);

  @override
  State<StepBooking> createState() => _StepBookingState();
}

class _StepBookingState extends State<StepBooking> {
  late String name;
  late String email;
  late String phone;

  // Future<void> insertBookingData(
  //   String fromStation,
  //   String toStation,
  //   String seats,
  //   String name,
  //   String email,
  //   String phone,
  //   String date,
  //   String time,
  //   String road,
  //   double paymentAmount,
  // ) async {
  //   final url =
  //       'http://localhost:8081/booking/create/cars'; // Update with your actual URL
  //   final paymentData = {
  //     'amount': paymentAmount,
  //     'recipitent': 'Worapong',
  //     'transactionId': '4100602853'
  //   };

  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode({
  //       'fromstation': fromStation,
  //       'tostation': toStation,
  //       'seat': seats,
  //       'name': name,
  //       'email': email,
  //       'phone': phone,
  //       'date': date,
  //       'time': time,
  //       'road': road,
  //       'payment': jsonEncode(paymentData)
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     print('Booking data inserted into MySQL successfully');
  //   } else {
  //     print(
  //         'Failed to insert booking data into MySQL: ${response.reasonPhrase}');
  //   }
  // }

  // Future<void> confirmBooking() async {
  //   final url = 'http://localhost:8081/booking/create/cars';
  //   final double paymentAmount = widget.selectedSeats.length * 30.0;
  //   final paymentData = {
  //     'amount': paymentAmount,
  //     'recipitent': 'Worapong',
  //     'transactionId': '4100602853'
  //   };

  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode({
  // 'fromstation': widget.fromStation,
  // 'tostation': widget.toStation,
  // 'number': widget.number,
  // 'seat': widget.selectedSeats.join(', '),
  // 'name': name,
  // 'email': email,
  // 'phone': phone,
  // 'date': widget.date,
  // 'time': widget.time,
  // 'road': widget.road,
  // 'payment': jsonEncode(paymentData)
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     print('Booking OK');
  //     final bookingData = {'payment': jsonEncode(paymentData)};
  //     final qrCodeData = jsonEncode(bookingData);
  //     Navigator.push(
  //       context,
  //       PageTransition(
  //         child: QRCodePaymentScreen(qrCodeData: jsonEncode(qrCodeData)),
  //         type: PageTransitionType.bottomToTop,
  //       ),
  //     );
  //   } else {
  //     print('Booking failed: ${response.reasonPhrase}');
  //   }
  // }
  Future<String> generateQRCode() async {
    final url =
        'http://localhost:8081/booking/create/qrcode'; // Update with your actual URL
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'amount': widget.selectedSeats.length * 30.0,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['Result'];
    } else {
      print('QR code generation failed: ${response.reasonPhrase}');
      return ''; // Return an empty string or some error message
    }
  }

  Future<void> confirmBooking() async {
    final qrCodeData = await generateQRCode();
    if (qrCodeData.isNotEmpty) {
      // await insertBookingData(
      //   widget.fromStation,
      //   widget.toStation,
      //   widget.selectedSeats.join(', '),
      //   name,
      //   email,
      //   phone,
      //   widget.date,
      //   widget.time,
      //   widget.road,
      //   widget.selectedSeats.length * 30.0,
      // );
      Navigator.push(
        context,
        PageTransition(
          child: QRCodePaymentScreen(qrCodeData: qrCodeData),
          type: PageTransitionType.bottomToTop,
        ),
      );
    }
//   Future<void> insertBookingData(
// ) async {
//   final url = 'http://localhost:8081/booking/create/cars'; // Update with your actual API endpoint
//   final response = await http.post(
//     Uri.parse(url),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode({
//         'fromstation': widget.fromStation,
//         'tostation': widget.toStation,
//         'number': widget.number,
//         'seat': widget.selectedSeats.join(', '),
//         'name': name,
//         'email': email,
//         'phone': phone,
//         'date': widget.date,
//         'time': widget.time,
//         'road': widget.road,
//         //'payment': jsonEncode(paymentData)
//     }),
//   );

//   if (response.statusCode == 200) {
//     print('Booking data inserted successfully');
//   } else {
//     print('Failed to insert booking data: ${response.reasonPhrase}');
//   }
// }
}

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    name = jwtDecodedToken['name'] ?? 'Unknown';
    email = jwtDecodedToken['email'] ?? 'Unknown';
    phone = jwtDecodedToken['phone'] ?? 'Unknown';
  }

  void _showPopup(BuildContext context, String road) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(
            'เส้นทางที่ผ่าน',
            style: GoogleFonts.notoSansThai(),
          ),
          content: Text('$road', style: GoogleFonts.notoSansThai()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ปิด popup เมื่อกดปุ่ม
              },
              child: Text(
                'ปิด',
                style: GoogleFonts.notoSansThai(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Selected Seats'),
      // ),
      body: Stack(
        children: [
          Container(
            width: 390,
            height: 844,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Color(0xFFF2F4F8),
            ),
          ),
          Column(
            children: [
              Container(
                width: 390,
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xFF4C2CA4),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 50,
                      right: 335,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_outlined,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 20,
                      child: Text(
                        'รายละเอียดการจอง',
                        style: GoogleFonts.notoSansThai(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 42),
              Container(
                width: 350,
                height: 150,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'VINVAN',
                            style: GoogleFonts.notoSansThai(
                              color: Color(0xFF4C2CA4),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'INFO',
                            style: GoogleFonts.notoSansThai(
                              color: Color(0xFF4C2CA4),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 50,
                        left: 10,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFAFAFA),
                            shape: OvalBorder(
                              side: BorderSide(
                                  width: 0.15, color: Color(0xFFBDBABA)),
                            ),
                          ),
                        )),
                    Positioned(
                      top: 42,
                      left: 29,
                      child: Text(
                        '${widget.fromStation}',
                        style: GoogleFonts.notoSansThai(
                            color: Color(0xFF1A1B1D),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 258,
                      child: Text(
                        'วันที่ ${widget.date}',
                        style: GoogleFonts.notoSansThai(
                            color: Color(0xFF1A1B1D),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Positioned(
                      top: 64,
                      left: 15,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(1.57),
                        child: Container(
                          width: 42,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.15,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Color(0xFFBBBBBB),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      left: 10,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: ShapeDecoration(
                          shape: OvalBorder(),
                          color: Color(0xFF4C2CA4),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 102,
                      left: 30,
                      child: Text(
                        '${widget.toStation}',
                        style: GoogleFonts.notoSansThai(
                            color: Color(0xFF1A1B1D),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      left: 270,
                      child: Text(
                        'เวลา : ${widget.time}',
                        style: GoogleFonts.notoSansThai(
                            color: Color(0xFF1A1B1D),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 9),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 140,
                      height: 80,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () => _showPopup(context, widget.road),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'กดเพิ่มดูเส้นทางที่ผ่าน',
                                style: GoogleFonts.notoSansThai(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blue),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 90,
                      height: 80,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ที่นั่ง',
                              style: GoogleFonts.notoSansThai(
                                color: Color(0xFF4C2CA4),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '${widget.selectedSeats.join(' , ')}',
                              style: GoogleFonts.notoSansThai(
                                color: Color(0xFF1A1B1D),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 90,
                      height: 80,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'มัดจำ',
                              style: GoogleFonts.notoSansThai(
                                color: Color(0xFF4C2CA4),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '${widget.selectedSeats.length * 30} บาท',
                              style: GoogleFonts.notoSansThai(
                                color: Color(0xFF1A1B1D),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 350,
                height: 187,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ข้อมูลส่วนตัว',
                            style: GoogleFonts.notoSansThai(
                              color: Color(0xFF4C2CA4),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 54,
                      left: 20,
                      child: Text(
                        'อีเมล : $email',
                        style: GoogleFonts.notoSansThai(
                            color: Color(0xFF1A1B1D),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Positioned(
                      top: 95,
                      left: 20,
                      child: Text(
                        'ชื่อ : $name',
                        style: GoogleFonts.notoSansThai(
                            color: Color(0xFF1A1B1D),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Positioned(
                      top: 135,
                      left: 20,
                      child: Text(
                        'เบอร์โทร : $phone ',
                        style: GoogleFonts.notoSansThai(
                            color: Color(0xFF1A1B1D),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  confirmBooking();
                },
                child: Container(
                  width: 330,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: Color(0xFF4C2CA4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'ยืนยันการจอง',
                      style: GoogleFonts.notoSansThai(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
