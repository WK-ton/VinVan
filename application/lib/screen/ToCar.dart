import 'package:flutter/material.dart';

class ToCar extends StatefulWidget {
  const ToCar({super.key});

  @override
  State<ToCar> createState() => _ToCarState();
}

class _ToCarState extends State<ToCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     'จุดเริ่มต้น',
      //     style: TextStyle(color: Colors.indigo),
      //   ),
      //   leading: TextButton(
      //     onPressed: () {
      //       Navigator.pop(context); // Navigate back to the previous page.
      //     },
      //     child: Text(
      //       'ปิด',
      //       style: TextStyle(color: Colors.indigo),
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ปิด',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                    child: Text(
                      'สถานีปลายทาง',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
