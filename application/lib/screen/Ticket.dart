import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:async';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Ticket extends StatefulWidget {
  const Ticket({@required this.token, Key? key});

  final token;

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  List<dynamic> data = [];
  bool hasNotified = false;

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
    fetchTicket();
  }

  Future<void> fetchTicket() async {
    final api1Url = 'http://localhost:8081/booking/get/booking';

    final api1Response = await http.get(Uri.parse(api1Url));

    if (api1Response.statusCode == 200) {
      final api1Json = jsonDecode(api1Response.body);
      final api1Cars = api1Json['data'];

      setState(() {
        data = api1Cars.where((notification) {
          return notification['name'] == name;
        }).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    data.sort((a, b) =>
        DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.qr_code_2),
        backgroundColor: const Color.fromARGB(255, 92, 36, 212),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        title: const Text('Ticket'),
        shadowColor: Colors.black,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                if (data.isEmpty) {
                  return CircularProgressIndicator();
                }
                final car = data[index];
                final fromstation = car['fromstation'];
                final tostation = car['tostation'];
                final number = car['number'];
                final time = car['time'];
                final formattedTime = time.substring(0, 5);
                final id = car['id'];
                final date = car['date'];

                final currentDate = DateTime.now();
                // วันที่ในฐานข้อมูล (ให้แปลงจาก String ให้เป็น DateTime ก่อน)
                final databaseDate = DateTime.parse(date);

                // เช็คว่าวันที่ในฐานข้อมูลไม่ตรงกับวันที่ปัจจุบัน
                final isDifferentDate = currentDate.isAfter(databaseDate);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: isDifferentDate ? Colors.grey[300] : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.indigo.withAlpha(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Stack(
                        children: [
                          Text(
                            'ID : $id',
                            style: GoogleFonts.notoSansThai(color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Text(
                              '$fromstation - $tostation',
                              style:
                                  GoogleFonts.notoSansThai(color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: Text(
                              '$formattedTime',
                              style: GoogleFonts.notoSansThai(
                                  color: Colors.black54),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(270, 50, 0, 0),
                            child: Text(
                              '$date',
                              style: GoogleFonts.notoSansThai(
                                  color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
