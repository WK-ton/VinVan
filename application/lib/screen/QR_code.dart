import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePaymentScreen extends StatelessWidget {
  final String qrCodeUrl;

  QRCodePaymentScreen(this.qrCodeUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Payment'),
        backgroundColor: Color(0xFF5C24D4),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qrCodeUrl, // ใช้ qrCodeUrl เพื่อสร้าง QR code
              version: QrVersions.auto,
              size: 300.0,
            ),
            SizedBox(height: 20),
            Text('Scan QR Code to Make Payment'),
          ],
        ),
      ),
    );
  }
}
