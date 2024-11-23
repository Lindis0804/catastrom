part of 'plans.bloc.dart';

class PlansState extends Equatable {
  final EPlans plansStatus;
  final LoadingStatus getMyPlansStatus;
  final List<Plan>? myPlans;
  final String? getMyPlansErrMsg, createPlanErrMsg;

  const PlansState(
      {required this.plansStatus,
      required this.getMyPlansStatus,
      this.myPlans,
      this.getMyPlansErrMsg,
      this.createPlanErrMsg});

  factory PlansState.initialize() {
    return const PlansState(
        plansStatus: EPlans.init, getMyPlansStatus: LoadingStatus.initialize);
  }

  PlansState copyWith(
      {EPlans? plansStatus,
      LoadingStatus? getMyPlansStatus,
      List<Plan>? myPlans,
      String? getMyPlansErrMsg,
      String? createPlanErrMsg}) {
    return PlansState(
        plansStatus: plansStatus ?? this.plansStatus,
        getMyPlansStatus: getMyPlansStatus ?? this.getMyPlansStatus,
        myPlans: myPlans ?? this.myPlans,
        getMyPlansErrMsg: getMyPlansErrMsg ?? this.getMyPlansErrMsg,
        createPlanErrMsg: createPlanErrMsg ?? this.createPlanErrMsg);
  }

  @override
  List<Object?> get props => [
        plansStatus,
        getMyPlansStatus,
        myPlans,
        getMyPlansErrMsg,
        createPlanErrMsg
      ];
}
