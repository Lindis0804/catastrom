import 'package:flutter/material.dart';

class CustomTextWithLeftIcon extends StatelessWidget {
  const CustomTextWithLeftIcon(
      {super.key, required this.image, required this.content});
  final ImageProvider image;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: image,
          width: 10,
          height: 10,
        ),
        Text(
          content,
          style: const TextStyle(fontSize: 8),
        )
      ],
    );
  }
}
