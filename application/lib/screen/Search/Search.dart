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

      if (newData.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'You have ${newData.length} new notifications.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 3),
          ),
        );
      }

      setState(() {
        data = newData;
      });
    } else {
      throw Exception('Failed to load data');
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
              color: Colors.white,
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
              title: Text('${index + 1}. ตั๋วของคุณยืนยันแล้ว ',
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
