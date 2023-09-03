import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchTicket();
  }

  Future<void> fetchTicket() async {
    final api1Url = 'http://localhost:8081/booking/get/booking';

    final api1Response = await http.get(Uri.parse(api1Url));

    if (api1Response.statusCode == 200) {
      final api1Json = jsonDecode(api1Response.body);
      final api1Cars = api1Json['data'];

      setState(() {
        data = api1Cars;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if (data.isEmpty) {
                      return CircularProgressIndicator(); // Display loading indicator when data is empty
                    }
                    final car = data[index];
                    final fromstation = car['fromstation'];
                    final tostation = car['tostation'];
                    final number = car['number'];
                    final time = car['time'];
                    final id = car['id'];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                                '#$id',
                                style: GoogleFonts.notoSansThai(
                                    color: Colors.grey),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                child: Text(
                                  '$fromstation - $tostation',
                                  style: GoogleFonts.notoSansThai(
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                                child: Text(
                                  '$time',
                                  style: GoogleFonts.notoSansThai(
                                      color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
