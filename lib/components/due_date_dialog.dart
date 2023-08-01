import 'package:flutter/material.dart';

class DueDate extends StatelessWidget {
  final VoidCallback datePicker;
  final VoidCallback dateToday;
  final VoidCallback dateTomorrow;

  const DueDate({required this.datePicker, super.key, required this.dateToday, required this.dateTomorrow});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Due',
                style: TextStyle(fontSize: 22),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Divider(height: 1),
            ),
            GestureDetector(
              onTap: () {
                dateToday.call();
              },
              child: const Row(
                children: [
                  Icon(Icons.calendar_today, size: 20),
                  SizedBox(width: 18),
                  Text('Today', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 22),
            GestureDetector(
              onTap: () {
                dateTomorrow.call();
              },
              child: const Row(
                children: [
                  Icon(Icons.calendar_today, size: 20),
                  SizedBox(width: 18),
                  Text('Tomorrow', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 22),
            GestureDetector(
              onTap: () {
                datePicker();
              },
              child: const Row(
                children: [
                  Icon(Icons.calendar_today, size: 20),
                  SizedBox(width: 18),
                  Text('Pick a Date', style: TextStyle(fontSize: 14)),
                  Spacer(),
                  Icon(Icons.chevron_right, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
