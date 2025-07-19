import 'package:flutter/material.dart';

class TripActionButtons extends StatelessWidget {
  final VoidCallback? onAddPressed;

  const TripActionButtons({
    Key? key,
    this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50, // Chiều rộng mong muốn
      height: 50, // Chiều cao mong muốn
      child: FloatingActionButton(
        shape: const CircleBorder(),
        heroTag: 'add',
        onPressed: onAddPressed,
        backgroundColor: const Color(0xFF205072),
        child: const Icon(Icons.add, color: Colors.white, size: 40),
      ),
    );

  }
}
