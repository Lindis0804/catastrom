import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';

class SubPlanDto {
  final int locationId;
  final String startTime, endTime;

  const SubPlanDto(
      {required this.locationId,
      required this.startTime,
      required this.endTime});
}

class ReqCreateTrip {
  final int numOfMembers;
  final String tripName, tripIntent, tripIntentDescription;
  final DateTime startTime, endTime;
  final double minBudget, maxBudget;
  final List<String> mainLocations;

  const ReqCreateTrip({
    required this.tripName,
    this.tripIntent = '',
    required this.startTime,
    required this.endTime,
    this.numOfMembers = 1,
    this.minBudget = 0,
    this.maxBudget = 0,
    this.mainLocations = const [],
    this.tripIntentDescription = '',
  });
  Map<String, dynamic> toJson() {
    return {
      'tripName': tripName,
      'tripIntent': tripIntent,
      'startDate': DateFormat('yyyyMMdd').format(startTime),
      'endDate': DateFormat('yyyyMMdd').format(endTime),
      'numOfParticipants': numOfMembers,
      'budget': maxBudget,
      'mainLocation': mainLocations,
      'intentDescription': tripIntentDescription,
    };
  }
}

class ResCreateTrip extends ReqCreateTrip {
  final String tripCode, createdBy;
  const ResCreateTrip({
    required String tripName,
    String tripIntent = '',
    required DateTime startTime,
    required DateTime endTime,
    int numOfMembers = 1,
    double minBudget = 0,
    double maxBudget = 0,
    List<String> mainLocations = const [],
    String tripIntentDescription = '',
    required this.tripCode,
    required this.createdBy,
  }) : super(
          tripName: tripName,
          tripIntent: tripIntent,
          startTime: startTime,
          endTime: endTime,
          numOfMembers: numOfMembers,
          minBudget: minBudget,
          maxBudget: maxBudget,
          mainLocations: mainLocations,
          tripIntentDescription: tripIntentDescription,
        );

  factory ResCreateTrip.fromDynamic(Map<String, dynamic> json) {
    List<String> mainLocations = List<String>.from(json['mainLocations'] ?? []);
    double minBudget = (json['minBudget'] as num?)?.toDouble() ?? 0.0;
    double maxBudget = (json['budget'] as num?)?.toDouble() ?? 0.0;

    String tripCode = json['tripCode']?.toString() ?? '';
    String createdBy = json['createdBy']?.toString() ?? '';
    String tripName = json['tripName']?.toString() ?? '';  // Fixed: was json['tripCode']
    String tripIntent = json['tripIntent']?.toString() ?? '';
    String tripIntentDescription = json['intentDescription']?.toString() ?? '';

    // Safe date parsing with fallbacks
    DateTime startTime;
    DateTime endTime;

    try {
      startTime = json['startDate'] != null
          ? DateTime.parse(json['startDate'].toString())
          : DateTime.now();
    } catch (e) {
      startTime = DateTime.now();
    }

    try {
      endTime = json['endDate'] != null
          ? DateTime.parse(json['endDate'].toString())
          : DateTime.now();
    } catch (e) {
      endTime = DateTime.now();
    }

    int numOfMembers = int.tryParse(json['numOfParticipants']?.toString() ?? '1') ?? 1;

    print('ResCreateTrip.fromDynamic parsed: tripName=$tripName, tripCode=$tripCode');

    return ResCreateTrip(
        tripCode: tripCode,
        createdBy: createdBy,
        tripName: tripName,
        tripIntent: tripIntent,
        startTime: startTime,
        endTime: endTime,
        numOfMembers: numOfMembers,
        minBudget: minBudget,
        maxBudget: maxBudget,
        mainLocations: mainLocations,
        tripIntentDescription: tripIntentDescription);
  }
}
