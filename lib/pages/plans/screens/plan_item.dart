import 'package:flutter/material.dart';
import 'package:template/common/widgets/custom_text_with_left_icon.dart';
import 'package:template/generated/assets.gen.dart';

class PlanItem extends StatelessWidget {
  const PlanItem(
      {super.key,
      required this.title,
      required this.description,
      required this.starting,
      required this.destination,
      required this.startingTime,
      required this.endTime});
  final String title;
  final String description;
  final String starting;
  final String destination;
  final String startingTime, endTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff205072), width: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Image(
              image: Assets.icons.plan.provider(),
              width: 30,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 8),
                ),
                CustomTextWithLeftIcon(
                    image: Assets.icons.location.provider(),
                    content: '$starting - $destination'),
                CustomTextWithLeftIcon(
                    image: Assets.icons.hourglass.provider(),
                    content: '$startingTime - $endTime')
              ],
            ),
          )
        ],
      ),
    );
  }
}
