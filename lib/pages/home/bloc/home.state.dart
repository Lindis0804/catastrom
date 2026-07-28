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
  final DateTime dateFrom, dateTo;
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
      required this.dateFrom,
      required this.dateTo,
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
    // Calendar-month placeholder only: real dateFrom/dateTo come from
    // GET /doc/current-expense-month (see HomeBloc._resolveCurrentExpenseMonth,
    // awaited before anything reads these) and overwrite this before use. This
    // is only the synchronous value shown for the instant before that resolves,
    // and the fallback if that call fails.
    return HomeState(
        homeStatus: HomeStatus.init,
        getUserStatus: LoadingStatus.initialize,
        getRecommenedPlacesStatus: LoadingStatus.initialize,
        getMyPlansStatus: LoadingStatus.initialize,
        getMonthlyTotalsStatus: LoadingStatus.initialize,
        getCurrentMonthSpentStatus: LoadingStatus.initialize,
        getDailyTotalsStatus: LoadingStatus.initialize,
        dateFrom: DateTime(now.year, now.month - 1),
        dateTo: DateTime(now.year, now.month));
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
      DateTime? dateFrom,
      DateTime? dateTo,
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
        dateFrom: dateFrom ?? this.dateFrom,
        dateTo: dateTo ?? this.dateTo,
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
        dateFrom,
        dateTo,
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
