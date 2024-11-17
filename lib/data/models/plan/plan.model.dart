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
  final Location location;
  final DateTime startTime, endTime;
  final String imageUrl;

  const SubPlan(
      {required this.id,
      required this.location,
      required this.startTime,
      required this.endTime,
      this.imageUrl =
          'https://cdn-images.vtv.vn/zoom/640_400/2021/3/14/cau-cua-hoi-1-vgp-16156627459431877593200.jpg'});
}

class Plan {
  final int id;
  final String name;
  final String address;
  final List<SubPlan>? subPlans;
  final List<Member>? members;
  final DateTime startTime, endTime;
  final double price;
  final String imageUrl;

  const Plan(
      {required this.id,
      required this.name,
      required this.address,
      this.subPlans,
      this.members,
      required this.startTime,
      required this.endTime,
      this.price = 0.0,
      this.imageUrl = 'https://i.ytimg.com/vi/2pH4Kr48zVo/maxresdefault.jpg'});
}
