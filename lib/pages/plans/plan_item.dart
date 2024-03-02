import 'package:flutter/material.dart';
import 'package:template/generated/assets.gen.dart';

class TextWithLeftIcon extends StatelessWidget {
  const TextWithLeftIcon(
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
              image: Assets.images.plan.provider(),
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
                TextWithLeftIcon(
                    image: Assets.images.location.provider(),
                    content: '$starting - $destination'),
                TextWithLeftIcon(
                    image: Assets.images.hourglass.provider(),
                    content: '$startingTime - $endTime')
              ],
            ),
          )
        ],
      ),
    );
  }
}
