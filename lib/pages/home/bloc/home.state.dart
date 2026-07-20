part of 'home.bloc.dart';

class HomeState extends Equatable {
  final HomeStatus homeStatus;

  final LoadingStatus getUserStatus,
      getRecommenedPlacesStatus,
      getMyPlansStatus,
      getMonthlyTotalsStatus,
      getCurrentMonthSpentStatus,
      getDailyTotalsStatus;
  final User? user;
  final List<RecommendedPlace>? recommendedPlaces;
  final List<Plan>? myPlans;
  final DateTime monthFrom, monthTo;
  final ESortOrder sortOrder;
  final List<MonthlyTotal>? monthlyTotals;
  final MonthlyTotal? currentMonthTotal;
  final List<TotalByDate>? dailyTotals;
  final String? getUserErrMsg,
      getRecommendedPlacesErrMsg,
      getMyPlansErrMsg,
      getMonthlyTotalsErrMsg,
      getCurrentMonthSpentErrMsg,
      getDailyTotalsErrMsg;

  const HomeState(
      {this.homeStatus = HomeStatus.init,
      this.getUserStatus = LoadingStatus.initialize,
      this.getRecommenedPlacesStatus = LoadingStatus.initialize,
      this.getMyPlansStatus = LoadingStatus.initialize,
      this.getMonthlyTotalsStatus = LoadingStatus.initialize,
      this.getCurrentMonthSpentStatus = LoadingStatus.initialize,
      this.getDailyTotalsStatus = LoadingStatus.initialize,
      this.user,
      this.recommendedPlaces,
      this.myPlans,
      required this.monthFrom,
      required this.monthTo,
      this.sortOrder = ESortOrder.asc,
      this.monthlyTotals,
      this.currentMonthTotal,
      this.dailyTotals,
      this.getUserErrMsg,
      this.getRecommendedPlacesErrMsg,
      this.getMyPlansErrMsg,
      this.getMonthlyTotalsErrMsg,
      this.getCurrentMonthSpentErrMsg,
      this.getDailyTotalsErrMsg});

  factory HomeState.initialize() {
    DateTime now = DateTime.now();
    return HomeState(
        homeStatus: HomeStatus.init,
        getUserStatus: LoadingStatus.initialize,
        getRecommenedPlacesStatus: LoadingStatus.initialize,
        getMyPlansStatus: LoadingStatus.initialize,
        getMonthlyTotalsStatus: LoadingStatus.initialize,
        getCurrentMonthSpentStatus: LoadingStatus.initialize,
        getDailyTotalsStatus: LoadingStatus.initialize,
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
      LoadingStatus? getDailyTotalsStatus,
      User? user,
      List<RecommendedPlace>? recommendedPlaces,
      List<Plan>? myPlans,
      DateTime? monthFrom,
      DateTime? monthTo,
      ESortOrder? sortOrder,
      List<MonthlyTotal>? monthlyTotals,
      MonthlyTotal? currentMonthTotal,
      List<TotalByDate>? dailyTotals,
      String? getUserErrMsg,
      String? getRecommendedPlacesErrMsg,
      String? getMyPlansErrMsg,
      String? getMonthlyTotalsErrMsg,
      String? getCurrentMonthSpentErrMsg,
      String? getDailyTotalsErrMsg}) {
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
        getDailyTotalsStatus: getDailyTotalsStatus ?? this.getDailyTotalsStatus,
        user: user ?? this.user,
        recommendedPlaces: recommendedPlaces ?? this.recommendedPlaces,
        myPlans: myPlans ?? this.myPlans,
        monthFrom: monthFrom ?? this.monthFrom,
        monthTo: monthTo ?? this.monthTo,
        sortOrder: sortOrder ?? this.sortOrder,
        monthlyTotals: monthlyTotals ?? this.monthlyTotals,
        currentMonthTotal: currentMonthTotal ?? this.currentMonthTotal,
        dailyTotals: dailyTotals ?? this.dailyTotals,
        getUserErrMsg: getUserErrMsg ?? this.getUserErrMsg,
        getRecommendedPlacesErrMsg:
            getRecommendedPlacesErrMsg ?? this.getRecommendedPlacesErrMsg,
        getMyPlansErrMsg: getMyPlansErrMsg ?? this.getMyPlansErrMsg,
        getMonthlyTotalsErrMsg:
            getMonthlyTotalsErrMsg ?? this.getMonthlyTotalsErrMsg,
        getCurrentMonthSpentErrMsg:
            getCurrentMonthSpentErrMsg ?? this.getCurrentMonthSpentErrMsg,
        getDailyTotalsErrMsg: getDailyTotalsErrMsg ?? this.getDailyTotalsErrMsg);
  }

  @override
  List<Object?> get props => [
        homeStatus,
        getUserStatus,
        getRecommenedPlacesStatus,
        getMyPlansStatus,
        getMonthlyTotalsStatus,
        getCurrentMonthSpentStatus,
        getDailyTotalsStatus,
        user,
        recommendedPlaces,
        myPlans,
        monthFrom,
        monthTo,
        sortOrder,
        monthlyTotals,
        currentMonthTotal,
        dailyTotals,
        getUserErrMsg,
        getRecommendedPlacesErrMsg,
        getMyPlansErrMsg,
        getMonthlyTotalsErrMsg,
        getCurrentMonthSpentErrMsg,
        getDailyTotalsErrMsg
      ];
}
