part of 'trip.bloc.dart';

abstract class TripEvent extends Equatable {
  const TripEvent();

  @override
  List<Object?> get props => [];
}

class Initialize extends TripEvent {
  const Initialize();
}

class GetMyPlansEvent extends TripEvent {
  final ReqParamsSearchTrip? reqParamsSearchTrip;

  const GetMyPlansEvent({
    this.reqParamsSearchTrip,
  });

  @override
  List<Object?> get props => [reqParamsSearchTrip];
}
