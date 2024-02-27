import 'package:flutter/material.dart';

class HomeNavigationBarIcon extends StatelessWidget {
  final IconData icon;
  HomeNavigationBarIcon({required this.icon});
  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 30);
  }
}
