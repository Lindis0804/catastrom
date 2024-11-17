part of 'home.bloc.dart';

class HomeState extends Equatable {
  final HomeStatus homeStatus;

  final LoadingStatus getUserStatus,
      getRecommenedPlacesStatus,
      getMyPlansStatus;
  final User? user;
  final List<RecommendedPlace>? recommendedPlaces;
  final List<Plan>? myPlans;
  final String? getUserErrMsg, getRecommendedPlacesErrMsg, getMyPlansErrMsg;

  const HomeState(
      {this.homeStatus = HomeStatus.init,
      this.getUserStatus = LoadingStatus.initialize,
      this.getRecommenedPlacesStatus = LoadingStatus.initialize,
      this.getMyPlansStatus = LoadingStatus.initialize,
      this.user,
      this.recommendedPlaces,
      this.myPlans,
      this.getUserErrMsg,
      this.getRecommendedPlacesErrMsg,
      this.getMyPlansErrMsg});

  factory HomeState.initialize() {
    return const HomeState(
        homeStatus: HomeStatus.init,
        getUserStatus: LoadingStatus.initialize,
        getRecommenedPlacesStatus: LoadingStatus.initialize,
        getMyPlansStatus: LoadingStatus.initialize);
  }

  HomeState copyWith(
      {HomeStatus? homeStatus,
      LoadingStatus? getUserStatus,
      LoadingStatus? getRecommenedPlacesStatus,
      LoadingStatus? getMyPlansStatus,
      User? user,
      List<RecommendedPlace>? recommendedPlaces,
      List<Plan>? myPlans,
      String? getUserErrMsg,
      String? getRecommendedPlacesErrMsg,
      String? getMyPlansErrMsg}) {
    return HomeState(
        homeStatus: homeStatus ?? this.homeStatus,
        getUserStatus: getUserStatus ?? this.getUserStatus,
        getRecommenedPlacesStatus:
            getRecommenedPlacesStatus ?? this.getRecommenedPlacesStatus,
        getMyPlansStatus: getMyPlansStatus ?? this.getMyPlansStatus,
        user: user ?? this.user,
        recommendedPlaces: recommendedPlaces ?? this.recommendedPlaces,
        myPlans: myPlans ?? this.myPlans,
        getUserErrMsg: getUserErrMsg ?? this.getUserErrMsg,
        getRecommendedPlacesErrMsg:
            getRecommendedPlacesErrMsg ?? this.getRecommendedPlacesErrMsg,
        getMyPlansErrMsg: getMyPlansErrMsg ?? this.getMyPlansErrMsg);
  }

  @override
  List<Object?> get props => [
        homeStatus,
        getUserStatus,
        getRecommenedPlacesStatus,
        getMyPlansStatus,
        user,
        recommendedPlaces,
        myPlans,
        getUserErrMsg,
        getRecommendedPlacesErrMsg,
        getMyPlansErrMsg
      ];
}
