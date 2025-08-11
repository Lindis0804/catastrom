import 'package:template/api/plan/dto/timeline.dart';

class ResUpdateTimeline {
  final Timeline timeline;
  final String? message;

  const ResUpdateTimeline({
    required this.timeline,
    this.message,
  });

  factory ResUpdateTimeline.fromJson(Map<String, dynamic> json) {
    return ResUpdateTimeline(
      timeline: Timeline.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': timeline.toJson(),
      'message': message,
    };
  }

  @override
  String toString() {
    return 'ResUpdateTimeline(timeline: $timeline, message: $message)';
  }
}
