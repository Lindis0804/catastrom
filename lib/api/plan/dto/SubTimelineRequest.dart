class SubTimelineRequest {
  final String locationCode;
  final String activityCode;
  final String startTime;
  final String endTime;

  const SubTimelineRequest({
    required this.locationCode,
    required this.activityCode,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'locationCode': locationCode,
      'activityCode': activityCode,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  @override
  String toString() {
    return 'SubTimelineRequest(locationCode: $locationCode, activityCode: $activityCode, startTime: $startTime, endTime: $endTime)';
  }
}
