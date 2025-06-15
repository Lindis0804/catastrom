part of 'plans.bloc.dart';

class PlansState extends Equatable {
  final EPlans plansStatus;
  final LoadingStatus getMyPlansStatus, deletePlanStatus;
  final List<Plan>? myPlans;
  final int plansPageSize, plansPageIdx;
  final String? getMyPlansErrMsg, createPlanErrMsg, deletePlanErrMsg;
  final List<String> searchOptions;
  final String selectedOption;
  final String? searchPlanKey;

  const PlansState({
    required this.plansStatus,
    required this.getMyPlansStatus,
    required this.deletePlanStatus,
    this.myPlans,
    this.getMyPlansErrMsg,
    this.createPlanErrMsg,
    this.deletePlanErrMsg,
    this.selectedOption = 'Tất cả',
    this.searchOptions = const ['Tất cả', 'Đã đi', 'Đang đi', 'Sẽ đi'],
    this.plansPageSize = 1000,
    this.plansPageIdx = 0,
    this.searchPlanKey,
  });

  factory PlansState.initialize() {
    return const PlansState(
        plansStatus: EPlans.init,
        getMyPlansStatus: LoadingStatus.initialize,
        deletePlanStatus: LoadingStatus.initialize,
        searchOptions: const ['Tất cả', 'Đã đi', 'Đang đi', 'Sẽ đi'],
        selectedOption: 'Tất cả',
        plansPageSize: 1000,
        plansPageIdx: 0);
  }

  PlansState copyWith(
      {EPlans? plansStatus,
      LoadingStatus? getMyPlansStatus,
      LoadingStatus? deletePlanStatus,
      List<Plan>? myPlans,
      String? getMyPlansErrMsg,
      String? createPlanErrMsg,
      String? deletePlanErrMsg,
      String? selectedOption,
      List<String>? searchOptions,
      int? plansPageSize,
      int? plansPageIdx,
      String? searchPlanKey}) {
    return PlansState(
      plansStatus: plansStatus ?? this.plansStatus,
      getMyPlansStatus: getMyPlansStatus ?? this.getMyPlansStatus,
      deletePlanStatus: deletePlanStatus ?? this.deletePlanStatus,
      myPlans: myPlans ?? this.myPlans,
      getMyPlansErrMsg: getMyPlansErrMsg ?? this.getMyPlansErrMsg,
      createPlanErrMsg: createPlanErrMsg ?? this.createPlanErrMsg,
      deletePlanErrMsg: deletePlanErrMsg ?? this.deletePlanErrMsg,
      selectedOption: selectedOption ?? this.selectedOption,
      searchOptions: searchOptions ?? this.searchOptions,
      plansPageSize: plansPageSize ?? this.plansPageSize,
      plansPageIdx: plansPageIdx ?? this.plansPageIdx,
      searchPlanKey: searchPlanKey ?? this.searchPlanKey,
    );
  }

  @override
  List<Object?> get props => [
        plansStatus,
        getMyPlansStatus,
        deletePlanStatus,
        myPlans,
        getMyPlansErrMsg,
        createPlanErrMsg,
        deletePlanErrMsg,
        selectedOption,
        searchOptions,
        plansPageSize,
        plansPageIdx,
        searchPlanKey
      ];
}
