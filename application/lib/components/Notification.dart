import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationModal extends StatelessWidget {
  final List<dynamic> data;


  NotificationModal({
    required this.data,

    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Notifications')),
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
