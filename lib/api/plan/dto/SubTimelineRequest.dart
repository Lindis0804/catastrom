import 'package:intl/intl.dart';

class SubTimelineRequest {
  final String locationCode;
  final String activityCode;
  final DateTime startTime;
  final DateTime endTime;
  final List<SubTimelineRequest> subTimelines;

  const SubTimelineRequest({
    required this.locationCode,
    required this.activityCode,
    required this.startTime,
    required this.endTime,
    required this.subTimelines,
  });

  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

    return {
      'locationCode': locationCode,
      'activityCode': activityCode,
      'startTime': formatter.format(startTime),
      'endTime': formatter.format(endTime),
      'subTimelines': subTimelines.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'SubTimelineRequest(locationCode: $locationCode, activityCode: $activityCode, startTime: $startTime, endTime: $endTime, subTimelines: $subTimelines)';
  }
}
