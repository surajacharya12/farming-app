import 'package:flutter/material.dart';
import 'package:flutter_bs_ad_calendar/flutter_bs_ad_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16), // Gap between AppBar and Calendar
          Expanded(
            child: FlutterBSADCalendar(
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2300),
              onDateSelected: (date, event) {
                setState(() {
                  selectedDate = date;
                });
              },
              onMonthChanged: (date, event) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
