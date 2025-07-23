import 'package:template/api/plan/dto/SubTimeline.dart';

class Timeline {
  final int id;
  final String locationCode;
  final String activityCode;
  final DateTime startTime;
  final DateTime endTime;
  final List<SubTimeline> subTimeLine;

  const Timeline({
    required this.id,
    required this.locationCode,
    required this.activityCode,
    required this.startTime,
    required this.endTime,
    required this.subTimeLine,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) {
    return Timeline(
      id: json['id'] as int,
      locationCode: json['locationCode'] as String,
      activityCode: json['activityCode'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      subTimeLine: (json['subTimeLine'] as List<dynamic>)
          .map((item) => SubTimeline.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'locationCode': locationCode,
      'activityCode': activityCode,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'subTimeLine': subTimeLine.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Timeline(id: $id, locationCode: $locationCode, activityCode: $activityCode, startTime: $startTime, endTime: $endTime, subTimeLine: $subTimeLine)';
  }
}
