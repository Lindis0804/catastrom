import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/place/dto/recommended_place.dart';
import 'package:template/api/place/provider.dart';
import 'package:template/api/plan/dto/ReqParamsSearchTrip.dart';
import 'package:template/api/plan/provider.dart';
import 'package:template/common/enums/home.enum.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/plan/plan.model.dart';
import 'package:template/data/models/user/user.model.dart';

part 'home.event.dart';
part 'home.state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initialize()) {
    on<Inititalize>(_onInitialize);

    add(
      const Inititalize(),
    );
  }

  void _onInitialize(
    HomeEvent event,
    Emitter<HomeState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }
    emitter(
      HomeState.initialize(),
    );
    User? user;
    List<RecommendedPlace>? recommendedPlaces;
    List<Plan>? myPlans;
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      await Future.wait(
        [
          () async {
            try {
              emitter(
                state.copyWith(getUserStatus: LoadingStatus.loading),
              );
              user = await SharedPreferencesManager.getUser();
              emitter(
                state.copyWith(user: user, getUserStatus: LoadingStatus.loaded),
              );
            } catch (err) {
              emitter(
                state.copyWith(
                    getUserErrMsg: 'Get user fail: $err',
                    getUserStatus: LoadingStatus.error),
              );
            }
          }(),
          () async {
            try {
              recommendedPlaces =
                  await PlaceApiProvider(accessToken: accessToken)
                      .getRecommenedPlaces(userId: 1);
              emitter(
                state.copyWith(
                    recommendedPlaces: recommendedPlaces,
                    getRecommenedPlacesStatus: LoadingStatus.loaded),
              );
            } catch (err) {
              emitter(
                state.copyWith(
                    getRecommendedPlacesErrMsg:
                        'Get recommended places fail: $err',
                    getRecommenedPlacesStatus: LoadingStatus.error),
              );
            }
          }(),
          () async {
            try {
              myPlans =
                  await PlanApiProvider(accessToken: accessToken).getMyPlans(
                reqParamsSearchTrip: ReqParamsSearchTrip(
                  pagable: ObjPagable(
                    page: 0,
                    size: 3,
                    sort: [],
                  ),
                ),
              );
              emitter(
                state.copyWith(
                    myPlans: myPlans, getMyPlansStatus: LoadingStatus.loaded),
              );
            } catch (err) {
              emitter(
                state.copyWith(
                    getMyPlansErrMsg: 'Get my plans fail: $err',
                    getMyPlansStatus: LoadingStatus.error),
              );
            }
          }()
        ],
      );
    } catch (err) {
      emitter(
        state.copyWith(
            getUserErrMsg: '$err', getUserStatus: LoadingStatus.error),
      );
    }
  }
}
