import 'package:template/api/plan/dto/sub_time_line_DTO.dart';

class Timeline {
  final int id;
  final String tripCode;
  final int? parentTimelineId; // Optional field for sub-timeline creation
  final String? locationCode;
  final String? activityCode;
  final DateTime startTime;
  final DateTime endTime;
  final List<SubTimeLineDTO> subTimeLine;

  const Timeline({
    required this.id,
    required this.tripCode,
    this.parentTimelineId,
    required this.locationCode,
    required this.activityCode,
    required this.startTime,
    required this.endTime,
    required this.subTimeLine,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) {
    return Timeline(
      id: json['id'] as int,
      tripCode: json['tripCode'] as String,
      parentTimelineId: json['parentTimelineId'] as int?,
      locationCode: json['locationCode'] as String?,
      activityCode: json['activityCode'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      subTimeLine: (json['subTimeLine'] as List<dynamic>? ?? [])
          .map((item) => SubTimeLineDTO.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripCode': tripCode,
      'parentTimelineId': parentTimelineId,
      'locationCode': locationCode,
      'activityCode': activityCode,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'subTimeLine': subTimeLine.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Timeline(id: $id, tripCode: $tripCode, parentTimelineId: $parentTimelineId, locationCode: $locationCode, activityCode: $activityCode, startTime: $startTime, endTime: $endTime, subTimeLine: $subTimeLine)';
  }
}
