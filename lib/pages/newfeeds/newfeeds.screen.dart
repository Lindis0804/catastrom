import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:template/common/widgets/custom_icon.dart';

class NewfeedsScreen extends StatefulWidget {
  const NewfeedsScreen({super.key});

  @override
  State<NewfeedsScreen> createState() => _NewfeedsScreenState();
}

class _NewfeedsScreenState extends State<NewfeedsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newfeeds'),
      ),
    );
  }
}
