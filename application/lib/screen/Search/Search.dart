import 'package:application/components/custom_icon.dart';
import 'package:application/screen/Search/Cars.dart';
import 'package:application/screen/Search/FromCar.dart';
import 'package:application/screen/Search/Time.dart';
import 'package:application/screen/Search/ToCar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SearchVan extends StatefulWidget {
  SearchVan({@required this.token, Key? key}) : super(key: key);

  @override
  State<SearchVan> createState() => _TestState();

  final token;
}

class _TestState extends State<SearchVan> {
  List<dynamic> data = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String FromStation = '';
  String ToStation = '';
  String Time = '';

  late String name;
  late String email;
  late String phone;

  bool emailSent = false;

  @override
  void initState() {
    super.initState();
    fetchNotification(context);
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    name = jwtDecodedToken['name'];
    email = jwtDecodedToken['email'];
    phone = jwtDecodedToken['phone'];
  }

  Future<void> fetchNotification(BuildContext context) async {
    final api1Url = 'http://localhost:8081/booking/get/booking';

    final api1Response = await http.get(Uri.parse(api1Url));

    if (api1Response.statusCode == 200) {
      final api1Json = jsonDecode(api1Response.body);
      final api1Cars = api1Json['data'];

      final newData = api1Cars.where((notification) {
        return notification['name'] == name;
      }).toList();

      setState(() {
        data = newData;
      });
      checkTimeForNotification();
    } else {
      throw Exception('Failed to load data');
    }
  }

  bool showContainer = false;

  void checkTimeForNotification() {
    final currentTime = DateTime.now();

    for (final car in data) {
      final time = car['time'];
      final timeParts = time.split(':');
      final carTime = DateTime(currentTime.year, currentTime.month,
          currentTime.day, int.parse(timeParts[0]), int.parse(timeParts[1]));

      final notificationTime = carTime.subtract(Duration(minutes: 30));

      if (currentTime.isBefore(carTime) &&
          currentTime.isAfter(notificationTime)) {
        showContainer = true;
        if (!emailSent) {
          sendEmail();
          emailSent = true;
        }
        break;
      }
    }
  }

  bool isNotificationTime(String time) {
    final currentTime = DateTime.now();
    final timeParts = time.split(':');
    final carTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, int.parse(timeParts[0]), int.parse(timeParts[1]));

    final notificationTime = carTime.subtract(Duration(minutes: 30));

    return currentTime.isBefore(carTime) &&
        currentTime.isAfter(notificationTime);
  }

  void sendEmail() async {
    String username = 'tonzaza181@gmail.com';
    String password = 'wbrgetarxpgdjrvv';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'รอบรถของคุณกำลังจะมาถึงอีก 15 นาที')
      ..recipients.add(email)
      ..subject = 'เตรียมตัวให้พร้อมน้าา ☺️'
      ..text = 'เตรียมตัวสำหรับการเดินทางของคุณ';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(255, 92, 36, 212),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              margin: EdgeInsets.only(top: size.height * 0.25),
              color: Color(0xFFF2F4F8),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Column(
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
                                    icon: Stack(
                                      children: [
                                        Icon(Icons
                                            .notifications_active_outlined),
                                        Positioned(
                                          right: 0,
                                          bottom: 6.5,
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors
                                                  .red, // You can use any color you prefer
                                            ),
                                            child: Text(
                                              '${data.length}', // This will display the number of notifications
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {
                                      // if (data.isNotEmpty) {
                                      //   // Show the SnackBar with the notification count
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(
                                      //     SnackBar(
                                      //       content: Text(
                                      //           'You have ${data.length} notifications.'),
                                      //       duration: Duration(
                                      //           seconds:
                                      //               3), // Adjust the duration as needed
                                      //     ),
                                      //   );
                                      // }
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return NotificationModal(
                                            data: data,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '🎊 $name',
                          style: GoogleFonts.notoSansThai(
                            fontWeight: FontWeight.w600,
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
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.location_on_outlined,
                                color: Colors.indigo,
                              ),
                            ),
                            SizedBox(width: 20.0),
                            TextButton(
                              onPressed: () async {
                                final selectedStation = await Navigator.push(
                                  context,
                                  PageTransition(
                                      child: FromCar(),
                                      type: PageTransitionType.bottomToTop),
                                );
                                if (selectedStation != null) {
                                  //print('Selected station: $selectedStation');
                                  setState(() {
                                    FromStation = selectedStation;
                                  });
                                }
                              },
                              child: Text(
                                'สถานีต้นทาง: $FromStation',
                                style: GoogleFonts.notoSansThai(
                                    color: Colors.indigo),
                              ),
                            )
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.location_on_outlined,
                                color: Colors.indigo,
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            TextButton(
                              onPressed: () async {
                                final selectedStation = await Navigator.push(
                                  context,
                                  PageTransition(
                                      child: toCar(),
                                      type: PageTransitionType.bottomToTop),
                                );
                                if (selectedStation != null) {
                                  print('Selected station: $selectedStation');
                                  setState(() {
                                    ToStation = selectedStation;
                                  });
                                }
                              },
                              child: Text(
                                'สถานีปลายทาง: $ToStation',
                                style: GoogleFonts.notoSansThai(
                                    color: Colors.indigo),
                              ),
                              //controller: locationTextController,
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_time_outlined,
                                color: Colors.indigo,
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            TextButton(
                              onPressed: () async {
                                final selectedStation = await Navigator.push(
                                  context,
                                  PageTransition(
                                      child: TimeSelect(),
                                      type: PageTransitionType.bottomToTop),
                                );
                                if (selectedStation != null) {
                                  print('Selected station: $selectedStation');
                                  setState(() {
                                    Time = selectedStation;
                                  });
                                }
                              },
                              child: Text(
                                'เลือกเวลา: $Time',
                                style: GoogleFonts.notoSansThai(
                                    color: Colors.indigo),
                              ),
                              //controller: locationTextController,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  child: Cars(
                                    fromStation: FromStation,
                                    toStation: ToStation,
                                    time: Time,
                                    token: widget.token,
                                  ),
                                  type: PageTransitionType.bottomToTop),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 92, 36, 212)),
                            elevation: MaterialStateProperty.all(0.0),
                            minimumSize:
                                MaterialStateProperty.all(const Size(200, 50)),
                          ),
                          child: Text(
                            'Search',
                            style: GoogleFonts.notoSans(),
                          ),
                        )
                      ],
                    ),
                  ),

                  const Divider(height: 20),
                  if (showContainer)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(220, 0, 0, 0),
                      child: Text(
                        'ใกล้ถึงกำหนด 🕐',
                        style: GoogleFonts.notoSansThai(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.red[400]),
                      ),
                    ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final car = data[index];
                        final time = car['time'];
                        final formattedTime = time.substring(0, 5);

                        // ตรวจสอบเงื่อนไขเวลาและแสดงข้อมูลเฉพาะเวลาที่ตรง
                        if (isNotificationTime(time)) {
                          final fromstation = car['fromstation'];
                          final tostation = car['tostation'];
                          final number = car['number'];
                          final date = car['date'];
                          final seat = car['seat'];
                          final id = car['id'];

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              width: 330,
                              height: 191,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.indigo.withAlpha(50),
                                ),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'ID : $id',
                                          style: GoogleFonts.notoSansThai(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 20,
                                    left: 273,
                                    child: Text(
                                      'สาย: $number',
                                      style: GoogleFonts.notoSansThai(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20,
                                    top: 50,
                                    child: Text(
                                      'จาก',
                                      style: GoogleFonts.notoSansThai(
                                        color: Color(0xFF9B9999),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20,
                                    top: 66,
                                    child: Text(
                                      fromstation,
                                      style: GoogleFonts.notoSansThai(
                                        color: Color(0xFF2D3D50),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20,
                                    top: 100,
                                    child: Text(
                                      'ถึง',
                                      style: GoogleFonts.notoSansThai(
                                        color: Color(0xFF9B9999),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20,
                                    top: 116,
                                    child: Text(
                                      tostation,
                                      style: GoogleFonts.notoSansThai(
                                        color: Color(0xFF2D3D50),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 50,
                                    left: 250,
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..translate(0.0, 0.0)
                                        ..rotateZ(1.56),
                                      child: Container(
                                        width: 90.01,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 0.50,
                                              strokeAlign:
                                                  BorderSide.strokeAlignCenter,
                                              color: Color(0xFFC9C8C8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 285,
                                    top: 50,
                                    child: Text(
                                      'รอบเวลา',
                                      style: GoogleFonts.notoSansThai(
                                        color: Color(0xFF9B9999),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 283,
                                    top: 66,
                                    child: Text(
                                      '$formattedTime',
                                      style: GoogleFonts.notoSansThai(
                                        color: Color(0xFF2D3D50),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 300,
                                    top: 100,
                                    child: Text(
                                      'วันที่',
                                      style: GoogleFonts.notoSansThai(
                                        color: Color(0xFF9B9999),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 260,
                                    top: 116,
                                    child: Text(
                                      '$date',
                                      style: GoogleFonts.notoSansThai(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 155,
                                    left: 20,
                                    child: Container(
                                      width: 289,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.50,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFC9C8C8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 165,
                                    left: 20,
                                    child: Text(
                                      'ที่นั่ง: $seat',
                                      style: GoogleFonts.notoSansThai(
                                        color: Color(0xFF2D3D50),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 163,
                                    left: 240,
                                    child: Container(
                                      width: 90,
                                      height: 20,
                                      decoration: ShapeDecoration(
                                        color:
                                            Color.fromARGB(255, 253, 166, 166),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Ticket Coming',
                                          style: GoogleFonts.notoSansThai(
                                            color: Color(0xFF4C2CA4),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Positioned(
                                  //   top: 153,
                                  //   left: 75,
                                  //   child: TextButton(
                                  //       onPressed: () {},
                                  //       child: Text(
                                  //         'กดเพื่อดูเพิ่มเติม',
                                  //         style: GoogleFonts.notoSansThai(
                                  //           color: Color(0xFF5C24D4),
                                  //           fontSize: 10,
                                  //           fontWeight: FontWeight.w400,
                                  //         ),
                                  //       )),
                                  // ),
                                  // Positioned(
                                  //   top: 167,
                                  //   left: 259,
                                  //   child: Text(
                                  //     'Buy Ticket',
                                  //     style: GoogleFonts.notoSansThai(
                                  //       color: Colors.indigo,
                                  //       fontSize: 12,
                                  //       fontWeight: FontWeight.w400,
                                  //     ),
                                  //   ),
                                  // ),
                                ]),
                              ),
                            ),
                          );
                        }

                        // ถ้าเงื่อนไขเวลาไม่ตรงกันให้ส่ง Container ว่างเพื่อไม่แสดงข้อมูลนี้
                        return Container();
                      },
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

class NotificationModal extends StatelessWidget {
  final List<dynamic> data;

  NotificationModal({required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Notifications'),
      content: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(10.0), // Adjust the border radius as needed
          color: Colors.white,
        ),
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final notification = data[index];
            // final name = notification['name'];
            final tostation = notification['tostation'];
            return ListTile(
              title: Text('ตั๋วของคุณยืนยันแล้ว ',
                  style: GoogleFonts.notoSansThai(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.green[400])),
              subtitle: Text(
                '$tostation ',
                style:
                    GoogleFonts.notoSansThai(fontSize: 13, color: Colors.grey),
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
