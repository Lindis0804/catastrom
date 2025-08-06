import 'package:template/api/plan/dto/timeline.dart';

class ResGetTimelineByTripCode {
  final List<Timeline> timelines;
  final String? message;

  const ResGetTimelineByTripCode({
    required this.timelines,
    this.message,
  });

  factory ResGetTimelineByTripCode.fromJson(Map<String, dynamic> json) {
    return ResGetTimelineByTripCode(
      timelines: json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map((item) => Timeline.fromJson(item as Map<String, dynamic>))
              .toList()
          : <Timeline>[], // Return empty list if data is null
      message: json['message'] != null ? json['message'] as String? : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': timelines.map((timeline) => timeline.toJson()).toList(),
      'message': message,
    };
  }

  @override
  String toString() {
    return 'ResGetTimelineByTripCode(timelines: $timelines, message: $message)';
  }
}
