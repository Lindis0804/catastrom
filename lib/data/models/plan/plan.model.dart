import 'package:template/data/models/location/location.model.dart';

class Member {
  final int id;
  final String username, firstName, lastName, phoneNumber;

  const Member(
      {required this.id,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});
}

class SubPlan {
  final int id;
  final int locationId;
  final DateTime startTime, endTime;
  final String imageUrl;

  const SubPlan(
      {required this.id,
      required this.locationId,
      required this.startTime,
      required this.endTime,
      this.imageUrl =
          'https://cdn-images.vtv.vn/zoom/640_400/2021/3/14/cau-cua-hoi-1-vgp-16156627459431877593200.jpg'});

  factory SubPlan.fromDynamic(dynamic rawSubPlan) {
    return SubPlan(
      id: rawSubPlan['id'],
      locationId: rawSubPlan['locationId'],
      startTime: DateTime.parse(rawSubPlan['startTime']),
      endTime: DateTime.parse(
        rawSubPlan['endTime'],
      ),
    );
  }
}

class Plan {
  final int id;
  final String? name;
  final String? address;
  final List<SubPlan>? subPlans;
  final List<Member>? members;
  final DateTime startTime, endTime;
  final double price;
  final String imageUrl;

  const Plan(
      {required this.id,
      this.name,
      this.address,
      this.subPlans,
      this.members,
      required this.startTime,
      required this.endTime,
      this.price = 0.0,
      this.imageUrl = 'https://i.ytimg.com/vi/2pH4Kr48zVo/maxresdefault.jpg'});

  factory Plan.fromDynamic(dynamic rawPlan) {
    int id = rawPlan['id'];
    String? name = rawPlan['name'];
    String? address = rawPlan['address'];
    DateTime startTime = DateTime.parse(rawPlan['startTime']);
    DateTime endTime = DateTime.parse(rawPlan['endTime']);
    double price = rawPlan['price'] ?? 0.0;

    dynamic rawSubPlans = rawPlan['subPlan'];
    List<SubPlan>? subPlans = rawSubPlans != null && rawSubPlans.length > 0
        ? List.generate(
            rawSubPlans.length,
            (idx) => SubPlan.fromDynamic(
              rawSubPlans[idx],
            ),
          )
        : null;

    return Plan(
        id: id,
        name: name,
        address: address,
        startTime: startTime,
        endTime: endTime,
        price: price,
        subPlans: subPlans);
  }
}
