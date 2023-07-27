import 'package:application/components/custom_icon.dart';
import 'package:application/screen/Search/FromCar.dart';
import 'package:application/screen/Search/ListCars.dart';
import 'package:application/screen/Search/Time.dart';
import 'package:application/screen/Search/ToCar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchVan extends StatefulWidget {
  SearchVan({@required this.token, Key? key}) : super(key: key);

  @override
  State<SearchVan> createState() => _TestState();

  final token;
}

class _TestState extends State<SearchVan> {
  String FromStation = '';
  String ToStation = '';
  String Time = '';

  late String name;
  late String email;
  late String phone;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    name = jwtDecodedToken['name'];
    email = jwtDecodedToken['email'];
    phone = jwtDecodedToken['phone'];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                      const Row(
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
                                  child: ListCars(
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
