
import 'package:template/common/enums/loading_status.enum.dart';

class CreateTimelineState {
  final LoadingStatus createTimelineStatus;
  final String? createTimelineErrMsg;

  const CreateTimelineState({
    this.createTimelineStatus = LoadingStatus.initialize,
    this.createTimelineErrMsg,
  });

  CreateTimelineState copyWith({
    LoadingStatus? createTimelineStatus,
    String? createTimelineErrMsg,
  }) {
    return CreateTimelineState(
      createTimelineStatus: createTimelineStatus ?? this.createTimelineStatus,
      createTimelineErrMsg: createTimelineErrMsg ?? this.createTimelineErrMsg,
    );
  }

  @override
  String toString() {
    return 'CreateTimelineState(createTimelineStatus: $createTimelineStatus, createTimelineErrMsg: $createTimelineErrMsg)';
  }
}
