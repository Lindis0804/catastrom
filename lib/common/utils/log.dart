import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message, int? duration) {
  duration = duration ?? 2;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
