import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:template/api/payment/provider.dart';
import 'package:template/api/place/dto/recommended_place.dart';
import 'package:template/api/place/provider.dart';
import 'package:template/api/plan/dto/ReqParamsSearchTrip.dart';
import 'package:template/api/plan/provider.dart';
import 'package:template/common/enums/home.enum.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/sort_order.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/payment/monthly_total.model.dart';
import 'package:template/data/models/payment/total_by_date.model.dart';
import 'package:template/data/models/plan/plan.model.dart';
import 'package:template/data/models/user/user.model.dart';

part 'home.event.dart';
part 'home.state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initialize()) {
    on<Inititalize>(_onInitialize);
    on<ChangeMonthFilterEvent>(_onChangeMonthFilter);
    on<ChangeSortOrderEvent>(_onChangeSortOrder);

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
          }(),
          _fetchMonthlyTotals(emitter),
          _fetchCurrentMonthSpent(emitter),
          _fetchDailyTotals(emitter),
        ],
      );
    } catch (err) {
      emitter(
        state.copyWith(
            getUserErrMsg: '$err', getUserStatus: LoadingStatus.error),
      );
    }
  }

  Future<void> _fetchMonthlyTotals(Emitter<HomeState> emitter) async {
    emitter(
      state.copyWith(getMonthlyTotalsStatus: LoadingStatus.loading),
    );
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      List<MonthlyTotal> monthlyTotals =
          await PaymentApiProvider(accessToken: accessToken).getTotalByMonth(
        from: state.monthFrom,
        to: state.monthTo,
        order: state.sortOrder.apiValue,
      );
      emitter(
        state.copyWith(
          monthlyTotals: monthlyTotals,
          getMonthlyTotalsStatus: LoadingStatus.loaded,
        ),
      );
    } catch (err) {
      emitter(
        state.copyWith(
          getMonthlyTotalsStatus: LoadingStatus.error,
          getMonthlyTotalsErrMsg: 'Get monthly totals fail: $err',
        ),
      );
    }
  }

  Future<void> _fetchCurrentMonthSpent(Emitter<HomeState> emitter) async {
    emitter(
      state.copyWith(getCurrentMonthSpentStatus: LoadingStatus.loading),
    );
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      DateTime now = DateTime.now();
      DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
      List<MonthlyTotal> monthlyTotals =
          await PaymentApiProvider(accessToken: accessToken).getTotalByMonth(
        from: firstDayOfMonth,
        to: now,
        order: 'DESC',
      );
      MonthlyTotal currentMonthTotal = monthlyTotals.isNotEmpty
          ? monthlyTotals.first
          : MonthlyTotal(
              month: DateFormat('MM/yyyy').format(now),
              total: 0,
              dateFrom: DateFormat('dd/MM/yyyy').format(firstDayOfMonth),
              dateTo: DateFormat('dd/MM/yyyy').format(now),
            );
      emitter(
        state.copyWith(
          currentMonthTotal: currentMonthTotal,
          getCurrentMonthSpentStatus: LoadingStatus.loaded,
        ),
      );
    } catch (err) {
      emitter(
        state.copyWith(
          getCurrentMonthSpentStatus: LoadingStatus.error,
          getCurrentMonthSpentErrMsg: 'Get current month spent fail: $err',
        ),
      );
    }
  }

  Future<void> _fetchDailyTotals(Emitter<HomeState> emitter) async {
    emitter(
      state.copyWith(getDailyTotalsStatus: LoadingStatus.loading),
    );
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      DateTime dateTo = DateTime.now();
      DateTime dateFrom = dateTo.subtract(const Duration(days: 6));
      List<TotalByDate> dailyTotals =
          await PaymentApiProvider(accessToken: accessToken).getTotalByDate(
        dateFrom: dateFrom,
        dateTo: dateTo,
        orderValue: 'ASC',
      );
      emitter(
        state.copyWith(
          dailyTotals: dailyTotals,
          getDailyTotalsStatus: LoadingStatus.loaded,
        ),
      );
    } catch (err) {
      emitter(
        state.copyWith(
          getDailyTotalsStatus: LoadingStatus.error,
          getDailyTotalsErrMsg: 'Get daily totals fail: $err',
        ),
      );
    }
  }

  void _onChangeMonthFilter(
    ChangeMonthFilterEvent event,
    Emitter<HomeState> emitter,
  ) async {
    emitter(
      state.copyWith(
        monthFrom: event.monthFrom,
        monthTo: event.monthTo,
      ),
    );
    await _fetchMonthlyTotals(emitter);
  }

  void _onChangeSortOrder(
    ChangeSortOrderEvent event,
    Emitter<HomeState> emitter,
  ) async {
    emitter(
      state.copyWith(sortOrder: event.order),
    );
    await _fetchMonthlyTotals(emitter);
  }
}
