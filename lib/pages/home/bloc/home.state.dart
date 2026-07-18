part of 'home.bloc.dart';

class HomeState extends Equatable {
  final HomeStatus homeStatus;

  final LoadingStatus getUserStatus,
      getRecommenedPlacesStatus,
      getMyPlansStatus,
      getMonthlyTotalsStatus,
      getCurrentMonthSpentStatus;
  final User? user;
  final List<RecommendedPlace>? recommendedPlaces;
  final List<Plan>? myPlans;
  final DateTime monthFrom, monthTo;
  final ESortOrder sortOrder;
  final List<MonthlyTotal>? monthlyTotals;
  final MonthlyTotal? currentMonthTotal;
  final String? getUserErrMsg,
      getRecommendedPlacesErrMsg,
      getMyPlansErrMsg,
      getMonthlyTotalsErrMsg,
      getCurrentMonthSpentErrMsg;

  const HomeState(
      {this.homeStatus = HomeStatus.init,
      this.getUserStatus = LoadingStatus.initialize,
      this.getRecommenedPlacesStatus = LoadingStatus.initialize,
      this.getMyPlansStatus = LoadingStatus.initialize,
      this.getMonthlyTotalsStatus = LoadingStatus.initialize,
      this.getCurrentMonthSpentStatus = LoadingStatus.initialize,
      this.user,
      this.recommendedPlaces,
      this.myPlans,
      required this.monthFrom,
      required this.monthTo,
      this.sortOrder = ESortOrder.asc,
      this.monthlyTotals,
      this.currentMonthTotal,
      this.getUserErrMsg,
      this.getRecommendedPlacesErrMsg,
      this.getMyPlansErrMsg,
      this.getMonthlyTotalsErrMsg,
      this.getCurrentMonthSpentErrMsg});

  factory HomeState.initialize() {
    DateTime now = DateTime.now();
    return HomeState(
        homeStatus: HomeStatus.init,
        getUserStatus: LoadingStatus.initialize,
        getRecommenedPlacesStatus: LoadingStatus.initialize,
        getMyPlansStatus: LoadingStatus.initialize,
        getMonthlyTotalsStatus: LoadingStatus.initialize,
        getCurrentMonthSpentStatus: LoadingStatus.initialize,
        monthFrom: DateTime(now.year, now.month - 1),
        monthTo: DateTime(now.year, now.month));
  }

  HomeState copyWith(
      {HomeStatus? homeStatus,
      LoadingStatus? getUserStatus,
      LoadingStatus? getRecommenedPlacesStatus,
      LoadingStatus? getMyPlansStatus,
      LoadingStatus? getMonthlyTotalsStatus,
      LoadingStatus? getCurrentMonthSpentStatus,
      User? user,
      List<RecommendedPlace>? recommendedPlaces,
      List<Plan>? myPlans,
      DateTime? monthFrom,
      DateTime? monthTo,
      ESortOrder? sortOrder,
      List<MonthlyTotal>? monthlyTotals,
      MonthlyTotal? currentMonthTotal,
      String? getUserErrMsg,
      String? getRecommendedPlacesErrMsg,
      String? getMyPlansErrMsg,
      String? getMonthlyTotalsErrMsg,
      String? getCurrentMonthSpentErrMsg}) {
    return HomeState(
        homeStatus: homeStatus ?? this.homeStatus,
        getUserStatus: getUserStatus ?? this.getUserStatus,
        getRecommenedPlacesStatus:
            getRecommenedPlacesStatus ?? this.getRecommenedPlacesStatus,
        getMyPlansStatus: getMyPlansStatus ?? this.getMyPlansStatus,
        getMonthlyTotalsStatus:
            getMonthlyTotalsStatus ?? this.getMonthlyTotalsStatus,
        getCurrentMonthSpentStatus:
            getCurrentMonthSpentStatus ?? this.getCurrentMonthSpentStatus,
        user: user ?? this.user,
        recommendedPlaces: recommendedPlaces ?? this.recommendedPlaces,
        myPlans: myPlans ?? this.myPlans,
        monthFrom: monthFrom ?? this.monthFrom,
        monthTo: monthTo ?? this.monthTo,
        sortOrder: sortOrder ?? this.sortOrder,
        monthlyTotals: monthlyTotals ?? this.monthlyTotals,
        currentMonthTotal: currentMonthTotal ?? this.currentMonthTotal,
        getUserErrMsg: getUserErrMsg ?? this.getUserErrMsg,
        getRecommendedPlacesErrMsg:
            getRecommendedPlacesErrMsg ?? this.getRecommendedPlacesErrMsg,
        getMyPlansErrMsg: getMyPlansErrMsg ?? this.getMyPlansErrMsg,
        getMonthlyTotalsErrMsg:
            getMonthlyTotalsErrMsg ?? this.getMonthlyTotalsErrMsg,
        getCurrentMonthSpentErrMsg:
            getCurrentMonthSpentErrMsg ?? this.getCurrentMonthSpentErrMsg);
  }

  @override
  List<Object?> get props => [
        homeStatus,
        getUserStatus,
        getRecommenedPlacesStatus,
        getMyPlansStatus,
        getMonthlyTotalsStatus,
        getCurrentMonthSpentStatus,
        user,
        recommendedPlaces,
        myPlans,
        monthFrom,
        monthTo,
        sortOrder,
        monthlyTotals,
        currentMonthTotal,
        getUserErrMsg,
        getRecommendedPlacesErrMsg,
        getMyPlansErrMsg,
        getMonthlyTotalsErrMsg,
        getCurrentMonthSpentErrMsg
      ];
}
