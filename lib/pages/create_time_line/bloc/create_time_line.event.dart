abstract class CreateTimelineEvent {
  const CreateTimelineEvent();
}

class CreateTimelineSubmitEvent extends CreateTimelineEvent {
  final String tripCode;
  final String locationCode;
  final String activityCode;
  final DateTime startTime;
  final DateTime endTime;

  const CreateTimelineSubmitEvent({
    required this.tripCode,
    required this.locationCode,
    required this.activityCode,
    required this.startTime,
    required this.endTime,
  });
}

class UpdateTimelineSubmitEvent extends CreateTimelineEvent {
  final int timelineId;
  final String tripCode;
  final String? locationCode;
  final String? activityCode;
  final DateTime startTime;
  final DateTime endTime;

  const UpdateTimelineSubmitEvent({
    required this.timelineId,
    required this.tripCode,
    this.locationCode,
    this.activityCode,
    required this.startTime,
    required this.endTime,
  });
}
