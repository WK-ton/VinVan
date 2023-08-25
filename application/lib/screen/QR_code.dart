import 'package:flutter/material.dart';
import 'dart:convert';

class QRCodePaymentScreen extends StatelessWidget {
  final String qrCodeData;

  const QRCodePaymentScreen({required this.qrCodeData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Payment'),
        backgroundColor: Color(0xFF4C2CA4),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(
              base64Decode(
                  qrCodeData.split(',')[1]), // Decode base64 image data
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              'Scan this QR code for payment',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
