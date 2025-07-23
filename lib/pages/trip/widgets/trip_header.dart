// Widget Header với title và nút thêm
import 'package:flutter/material.dart';

class TripHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onAddPressed;

  const TripHeader({
    Key? key,
    required this.title,
    this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: onAddPressed,
          child: Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              color: Color(0xFF2B5F7F),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}