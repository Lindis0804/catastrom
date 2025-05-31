import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

class CustomDateTimePicker {
  static showDateTimePicker(
      BuildContext context, dynamic Function(DateTime, List<int>) _onConfirm) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd/MM/yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: _onConfirm,
    );
  }
}
