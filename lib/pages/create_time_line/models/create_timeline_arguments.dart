import 'package:template/api/plan/dto/timeline.dart';

class CreateTimelineArguments {
  final String? tripCode;
  final Timeline? timelineToEdit;

  const CreateTimelineArguments({
    this.tripCode,
    this.timelineToEdit,
  });

  @override
  String toString() {
    return 'CreateTimelineArguments(tripCode: $tripCode, timelineToEdit: $timelineToEdit)';
  }
}
