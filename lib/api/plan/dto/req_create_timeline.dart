import 'package:template/api/plan/dto/sub_time_line_DTO.dart';

class ReqCreateTimeline {
  final String tripCode;
  final int? id;
  final int?
      parentTimelineId; // Add this field to support sub-timeline creation
  final String locationCode;
  final String activityCode;
  final DateTime startTime;
  final DateTime endTime;
  final List<SubTimeLineDTO> subTimeLine;

  const ReqCreateTimeline({
    required this.tripCode,
    this.id,
    this.parentTimelineId,
    required this.locationCode,
    required this.activityCode,
    required this.startTime,
    required this.endTime,
    required this.subTimeLine,
  });

  Map<String, dynamic> toJson() {
    return {
      'tripCode': tripCode,
      'id': id,
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
    return 'ReqCreateTimeline(tripCode: $tripCode, id: $id, parentTimelineId: $parentTimelineId, locationCode: $locationCode, activityCode: $activityCode, startTime: $startTime, endTime: $endTime, subTimeLine: $subTimeLine)';
  }
}
