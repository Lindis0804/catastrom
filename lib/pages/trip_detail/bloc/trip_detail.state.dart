part of 'trip_detail.bloc.dart';

class TripDetailState extends Equatable {
  final Plan? selectedPlan;
  final LoadingStatus status;
  final String? errorMessage;
  final List<Timeline>? timelines;
  final LoadingStatus timelineStatus;
  final String? timelineErrorMessage;

  const TripDetailState({
    this.selectedPlan,
    required this.status,
    this.errorMessage,
    this.timelines,
    required this.timelineStatus,
    this.timelineErrorMessage,
  });

  factory TripDetailState.initialize() {
    return const TripDetailState(
      selectedPlan: null,
      status: LoadingStatus.initialize,
      errorMessage: null,
      timelines: null,
      timelineStatus: LoadingStatus.initialize,
      timelineErrorMessage: null,
    );
  }

  TripDetailState copyWith({
    Plan? selectedPlan,
    LoadingStatus? status,
    String? errorMessage,
    List<Timeline>? timelines,
    LoadingStatus? timelineStatus,
    String? timelineErrorMessage,
  }) {
    return TripDetailState(
      selectedPlan: selectedPlan ?? this.selectedPlan,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      timelines: timelines ?? this.timelines,
      timelineStatus: timelineStatus ?? this.timelineStatus,
      timelineErrorMessage: timelineErrorMessage ?? this.timelineErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        selectedPlan,
        status,
        errorMessage,
        timelines,
        timelineStatus,
        timelineErrorMessage,
      ];
}
