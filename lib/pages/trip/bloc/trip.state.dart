part of 'trip.bloc.dart';

class TripState extends Equatable {
  final LoadingStatus getMyPlansStatus;
  final List<Plan>? myPlans;
  final String? getMyPlansErrMsg;

  const TripState({
    required this.getMyPlansStatus,
    this.myPlans,
    this.getMyPlansErrMsg,
  });

  factory TripState.initialize() {
    return const TripState(
      getMyPlansStatus: LoadingStatus.initialize,
      myPlans: null,
      getMyPlansErrMsg: null,
    );
  }

  TripState copyWith({
    LoadingStatus? getMyPlansStatus,
    List<Plan>? myPlans,
    String? getMyPlansErrMsg,
  }) {
    return TripState(
      getMyPlansStatus: getMyPlansStatus ?? this.getMyPlansStatus,
      myPlans: myPlans ?? this.myPlans,
      getMyPlansErrMsg: getMyPlansErrMsg ?? this.getMyPlansErrMsg,
    );
  }

  @override
  List<Object?> get props => [
        getMyPlansStatus,
        myPlans,
        getMyPlansErrMsg,
      ];
}
