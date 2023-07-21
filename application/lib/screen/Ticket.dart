import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
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
      body: Center(child: Text("Ticket")),
    );
  }
}
