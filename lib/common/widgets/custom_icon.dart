import 'package:flutter/material.dart';

class ManageNavigationBarIcon extends StatelessWidget {
  final IconData icon;
  const ManageNavigationBarIcon({required this.icon, super.key});
  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 30);
  }
}
