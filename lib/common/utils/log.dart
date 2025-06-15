import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message, int? duration) {
  duration = duration ?? 2;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void showToast(
    {required BuildContext context,
    required String message,
    int duration = 1}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
