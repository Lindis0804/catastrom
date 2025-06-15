import 'package:flutter/widgets.dart';
import 'package:template/common/widgets/custom_image.widget.dart';
import 'package:template/data/models/plan/plan.model.dart';
import 'package:template/pages/home/screen/date.widget.dart';
import 'package:template/pages/home/screen/location_name.widget.dart';

class MyPlanItem extends StatelessWidget {
  final Plan plan;
  const MyPlanItem({required this.plan, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(230, 238, 250, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImage.network(
              imageUrl: plan.imageUrl, width: 50, height: 50, radius: 10),
          const SizedBox(
            width: 7,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${plan.name}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  WidLocationName(location: '${plan.address}'),
                  const SizedBox(
                    width: 5,
                  ),
                  WidDate(date: plan.startTime)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
