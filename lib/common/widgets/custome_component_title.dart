import 'package:flutter/cupertino.dart';

class ComponentTitle extends StatelessWidget {
  final String title;

  const ComponentTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
      ),
    );
  }
}
