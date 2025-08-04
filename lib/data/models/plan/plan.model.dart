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
  final String tripCode, tripIntent, type, intentDescription;
  final int numberOfParticipants;
  final String? name;
  final String? address;
  final List<SubPlan>? subPlans;
  final List<Member>? members;
  final DateTime startTime, endTime;
  final double price;
  final String imageUrl;
  final List<String> mainLocations;
  final String createdBy;

  const Plan(
      {required this.id,
      required this.tripCode,
      required this.tripIntent,
      required this.type,
      required this.intentDescription,
      required this.numberOfParticipants,
      required this.mainLocations,
      this.name,
      this.address,
      this.subPlans,
      this.members,
      required this.startTime,
      required this.endTime,
      this.price = 0.0,
      this.imageUrl = 'https://i.ytimg.com/vi/2pH4Kr48zVo/maxresdefault.jpg',
      required this.createdBy});

  factory Plan.fromDynamic(dynamic rawPlan) {
    int id = rawPlan['id'] ?? 0;
    String? name = rawPlan['tripName'];
    String createdBy = rawPlan['createdBy'] ?? '';
    String tripCode = rawPlan['tripCode'] ?? '';
    String tripIntent = rawPlan['tripIntent'] ?? '';
    String type = rawPlan['type'] ?? 'default';
    String intentDescription = rawPlan['intentDescription'] ?? '';
    int numberOfParticipants = rawPlan['numberOfParticipants'] ?? 1;
    List<String> mainLocations =
        List<String>.from(rawPlan['mainLocations'] ?? []);
    String? address = rawPlan['address'];
    DateTime startTime = DateTime.parse(rawPlan['startDate']);
    DateTime endTime = DateTime.parse(rawPlan['endDate']);
    double price = rawPlan['budget'] ?? 0.0;

    return Plan(
      id: id,
      tripCode: tripCode,
      tripIntent: tripIntent,
      createdBy: createdBy,
      type: type,
      intentDescription: intentDescription,
      numberOfParticipants: numberOfParticipants,
      mainLocations: mainLocations,
      name: name,
      address: address,
      startTime: startTime,
      endTime: endTime,
      price: price,
    );
  }
}
