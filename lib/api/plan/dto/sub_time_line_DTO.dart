class SubTimeLineDTO {
  final int? id;
  final String locationCode;
  final String activityCode;
  final DateTime startTime;
  final DateTime endTime;
  final List<SubTimeLineDTO> subTimeLine;

  const SubTimeLineDTO({
    this.id,
    required this.locationCode,
    required this.activityCode,
    required this.startTime,
    required this.endTime,
    required this.subTimeLine,
  });

  factory SubTimeLineDTO.fromJson(Map<String, dynamic> json) {
    return SubTimeLineDTO(
      id: json['id'] as int?,
      locationCode: json['locationCode'] as String,
      activityCode: json['activityCode'] as String,
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
      'locationCode': locationCode,
      'activityCode': activityCode,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'subTimeLine': subTimeLine.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'SubTimeLineDTO(id: $id, locationCode: $locationCode, activityCode: $activityCode, startTime: $startTime, endTime: $endTime, subTimeLine: $subTimeLine)';
  }
}
