import 'package:flutter/material.dart';

class WidLocationName extends StatelessWidget {
  final String location;

  const WidLocationName({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: Colors.green,
        ),
        SizedBox(
          width: 100,
          child: Text(
            location,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
