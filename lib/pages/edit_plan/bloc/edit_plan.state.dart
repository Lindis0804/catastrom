part of 'edit_plan.bloc.dart';

class NewPlanState extends Equatable {
  final LoadingStatus createPlanStatus, getSectionsStatus;
  final Plan? createdPlan;
  final String? createPlanErrMsg;
  final List<SectionItem>? sections;

  const NewPlanState(
      {required this.createPlanStatus,
      this.createdPlan,
      this.createPlanErrMsg,
      this.sections,
      this.getSectionsStatus = LoadingStatus.initialize});

  factory NewPlanState.initialize() {
    return const NewPlanState(
      createPlanStatus: LoadingStatus.initialize,
    );
  }

  NewPlanState copyWith(
      {LoadingStatus? createPlanStatus,
      LoadingStatus? getSectionsStatus,
      String? createPlanErrMsg,
      Plan? createdPlan,
      List<SectionItem>? sections}) {
    return NewPlanState(
        createPlanStatus: createPlanStatus ?? this.createPlanStatus,
        createPlanErrMsg: createPlanErrMsg ?? this.createPlanErrMsg,
        createdPlan: createdPlan ?? this.createdPlan,
        sections: sections ?? this.sections,
        getSectionsStatus: getSectionsStatus ?? this.getSectionsStatus);
  }

  @override
  List<Object?> get props => [
        createPlanStatus,
        createdPlan,
        createPlanErrMsg,
        sections,
        getSectionsStatus
      ];
}
