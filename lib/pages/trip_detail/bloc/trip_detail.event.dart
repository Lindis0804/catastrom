part of 'trip_detail.bloc.dart';

abstract class TripDetailEvent extends Equatable {
  const TripDetailEvent();

  @override
  List<Object?> get props => [];
}

class SetSelectedPlan extends TripDetailEvent {
  final Plan plan;

  const SetSelectedPlan({required this.plan});

  @override
  List<Object?> get props => [plan];
}

class ClearSelectedPlan extends TripDetailEvent {
  const ClearSelectedPlan();
}

class GetTimelineByTripCode extends TripDetailEvent {
  final String tripCode;

  const GetTimelineByTripCode({required this.tripCode});

  @override
  List<Object?> get props => [tripCode];
}

class DeleteTimeline extends TripDetailEvent {
  final int timelineId;

  const DeleteTimeline({required this.timelineId});

  @override
  List<Object?> get props => [timelineId];
}
