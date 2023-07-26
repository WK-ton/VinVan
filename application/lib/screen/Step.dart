import 'package:flutter/material.dart';

class StepBooking extends StatelessWidget {
  final List<String> selectedSeats;
  final String number;
  final String fromStation;
  final String toStation;
  final String time;
  final String date;

  const StepBooking({
    Key? key,
    required this.selectedSeats,
    required this.number,
    required this.fromStation,
    required this.toStation,
    required this.time,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Seats'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              '$fromStation - $toStation',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'สาย : $number',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'ที่นั่ง : ${selectedSeats.join(', ')}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'เวลา : $time',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'วันที่ : $date',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
