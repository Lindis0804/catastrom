part of 'new_plan.bloc.dart';

class NewPlanState extends Equatable {
  final LoadingStatus createPlanStatus;
  final Plan? createdPlan;
  final String? createPlanErrMsg;
  const NewPlanState(
      {required this.createPlanStatus,
      this.createdPlan,
      this.createPlanErrMsg});

  factory NewPlanState.initialize() {
    return const NewPlanState(
      createPlanStatus: LoadingStatus.initialize,
    );
  }

  NewPlanState copyWith(
      {LoadingStatus? createPlanStatus, String? createPlanErrMsg}) {
    return NewPlanState(
        createPlanStatus: createPlanStatus ?? this.createPlanStatus,
        createPlanErrMsg: createPlanErrMsg ?? this.createPlanErrMsg);
  }

  @override
  List<Object?> get props => [createPlanStatus, createdPlan, createPlanErrMsg];
}
