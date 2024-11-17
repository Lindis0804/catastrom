import 'package:flutter/material.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/pages/plans/custom_app_bar.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(name: "Hiếu"),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Danh sách lịch trình',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff205072),
                        fontSize: 20),
                  ),
                ),
                BigCustomButton(onPressed: () {}, text: 'Tạo mới')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
