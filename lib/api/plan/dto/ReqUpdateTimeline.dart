import 'package:template/api/plan/dto/sub_time_line_DTO.dart';

class ReqUpdateTimeline {
  final int id;
  final String tripCode;
  final String? locationCode;
  final String? activityCode;
  final DateTime startTime;
  final DateTime endTime;
  final List<SubTimeLineDTO> subTimeline;

  const ReqUpdateTimeline({
    required this.id,
    required this.tripCode,
    this.locationCode,
    this.activityCode,
    required this.startTime,
    required this.endTime,
    required this.subTimeline,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripCode': tripCode,
      'locationCode': locationCode,
      'activityCode': activityCode,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'subTimeline': subTimeline.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ReqUpdateTimeline(id: $id, tripCode: $tripCode, locationCode: $locationCode, activityCode: $activityCode, startTime: $startTime, endTime: $endTime, subTimeline: $subTimeline)';
  }
}
