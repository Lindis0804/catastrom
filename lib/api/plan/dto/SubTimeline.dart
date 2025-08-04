class SubTimeline {
  final String locationCode;
  final String activityCode;
  final DateTime startTime;
  final DateTime endTime;

  const SubTimeline({
    required this.locationCode,
    required this.activityCode,
    required this.startTime,
    required this.endTime,
  });

  factory SubTimeline.fromJson(Map<String, dynamic> json) {
    return SubTimeline(
      locationCode: json['locationCode'] as String,
      activityCode: json['activityCode'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationCode': locationCode,
      'activityCode': activityCode,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'SubTimeline(locationCode: $locationCode, activityCode: $activityCode, startTime: $startTime, endTime: $endTime)';
  }
}
