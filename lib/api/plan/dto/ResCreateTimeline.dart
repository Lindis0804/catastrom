class ResCreateTimeline {
  final int? id;
  final String? locationCode;
  final String? activityCode;
  final DateTime? startTime;
  final DateTime? endTime;
  final List<SubTimelineResponse>? subTimeLine;
  final String? message;
  final bool success;

  const ResCreateTimeline({
    this.id,
    this.locationCode,
    this.activityCode,
    this.startTime,
    this.endTime,
    this.subTimeLine,
    this.message,
    required this.success,
  });

  factory ResCreateTimeline.fromJson(Map<String, dynamic> json) {
    // Handle case where response_code exists (API response wrapper)
    if (json.containsKey('response_code')) {
      final bool isSuccess = json['response_code'] == '0000';
      final Map<String, dynamic>? data = json['data'];

      if (isSuccess && data != null) {
        return ResCreateTimeline._fromData(data, isSuccess, json['message']);
      } else {
        return ResCreateTimeline(
          success: isSuccess,
          message: json['message'] ?? json['params']?['message'],
        );
      }
    } else {
      // Direct data response
      return ResCreateTimeline._fromData(json, true, null);
    }
  }

  factory ResCreateTimeline._fromData(
      Map<String, dynamic> data, bool success, String? message) {
    return ResCreateTimeline(
      id: data['id'] as int?,
      locationCode: data['locationCode'] as String?,
      activityCode: data['activityCode'] as String?,
      startTime: data['startTime'] != null
          ? DateTime.parse(data['startTime'])
          : null,
      endTime: data['endTime'] != null ? DateTime.parse(data['endTime']) : null,
      subTimeLine: data['subTimeLine'] != null
          ? (data['subTimeLine'] as List<dynamic>)
              .map((item) =>
                  SubTimelineResponse.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      success: success,
      message: message,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'locationCode': locationCode,
      'activityCode': activityCode,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'subTimeLine': subTimeLine?.map((item) => item.toJson()).toList(),
      'success': success,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'ResCreateTimeline(id: $id, locationCode: $locationCode, activityCode: $activityCode, startTime: $startTime, endTime: $endTime, subTimeLine: $subTimeLine, success: $success, message: $message)';
  }
}

class SubTimelineResponse {
  final String locationCode;
  final String activityCode;
  final DateTime startTime;
  final DateTime endTime;

  const SubTimelineResponse({
    required this.locationCode,
    required this.activityCode,
    required this.startTime,
    required this.endTime,
  });

  factory SubTimelineResponse.fromJson(Map<String, dynamic> json) {
    return SubTimelineResponse(
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
    return 'SubTimelineResponse(locationCode: $locationCode, activityCode: $activityCode, startTime: $startTime, endTime: $endTime)';
  }
}
