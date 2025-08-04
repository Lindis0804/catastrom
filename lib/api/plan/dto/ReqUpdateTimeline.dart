import 'package:template/api/plan/dto/SubTimeline.dart';

class ReqUpdateTimeline {
  final int timelineId;
  final String tripCode;
  final String locationCode;
  final String activityCode;
  final DateTime startTime;
  final DateTime endTime;
  final List<SubTimeline> subTimelines;

  const ReqUpdateTimeline({
    required this.timelineId,
    required this.tripCode,
    required this.locationCode,
    required this.activityCode,
    required this.startTime,
    required this.endTime,
    required this.subTimelines,
  });

  Map<String, dynamic> toJson() {
    return {
      'timelineId': timelineId,
      'tripCode': tripCode,
      'locationCode': locationCode,
      'activityCode': activityCode,
      'startTime':
          '${startTime.year.toString().padLeft(4, '0')}-${startTime.month.toString().padLeft(2, '0')}-${startTime.day.toString().padLeft(2, '0')} ${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}:${startTime.second.toString().padLeft(2, '0')}',
      'endTime':
          '${endTime.year.toString().padLeft(4, '0')}-${endTime.month.toString().padLeft(2, '0')}-${endTime.day.toString().padLeft(2, '0')} ${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}:${endTime.second.toString().padLeft(2, '0')}',
      'subTimelines': subTimelines.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ReqUpdateTimeline(timelineId: $timelineId, tripCode: $tripCode, locationCode: $locationCode, activityCode: $activityCode, startTime: $startTime, endTime: $endTime, subTimelines: $subTimelines)';
  }
}
