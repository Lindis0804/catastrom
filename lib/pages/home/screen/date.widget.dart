import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidDate extends StatelessWidget {
  final DateTime date;

  const WidDate({required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.calendar_month,
          color: Colors.green,
        ),
        Text(
          DateFormat('dd/MM/yyyy').format(date),
        )
      ],
    );
  }
}
