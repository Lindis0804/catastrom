import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/plan/dto/ReqParamsSearchTrip.dart';
import 'package:template/api/plan/provider.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/plan/plan.model.dart';

part 'trip.event.dart';
part 'trip.state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc() : super(TripState.initialize()) {
    on<Initialize>(_onInitialize);
    on<GetMyPlansEvent>(_onGetMyPlans);

    print('TripBloc: Constructor called, adding Initialize event');
    add(const Initialize());
  }

  void _onInitialize(
    Initialize event,
    Emitter<TripState> emitter,
  ) async {
    print('TripBloc: _onInitialize called');
    // Initialize the trip page and load initial data
    print('TripBloc: Adding GetMyPlansEvent from initialization...');
    add(const GetMyPlansEvent());
  }

  void _onGetMyPlans(
    GetMyPlansEvent event,
    Emitter<TripState> emitter,
  ) async {
    print('TripBloc: _onGetMyPlans called - START');
    print('TripBloc: Event params: ${event.reqParamsSearchTrip}');

    emitter(
      state.copyWith(
        getMyPlansStatus: LoadingStatus.loading,
      ),
    );
    print('TripBloc: State updated to loading');

    try {
      print('TripBloc: Getting access token...');
      final String accessToken = await SharedPreferencesManager.getAccessToken();
      print('TripBloc: Access token retrieved: ${accessToken.isNotEmpty ? "✓" : "✗"}');

      final String? userIdNullable = await SharedPreferencesManager.getString(SPKeys.USER_ID);
      final String userId = userIdNullable ?? '';
      print('TripBloc: User ID retrieved: $userId');

      final ReqParamsSearchTrip reqParamsSearchTrip = event.reqParamsSearchTrip ??
          ReqParamsSearchTrip(
            pagable: ObjPagable(
              page: 0,
              size: 20,
              sort: [],
            ),
          );

      // Set userId if not already provided
      reqParamsSearchTrip.userId ??= userId;
      print('TripBloc: Request params prepared: userId=${reqParamsSearchTrip.userId}, page=${reqParamsSearchTrip.pagable.page}, size=${reqParamsSearchTrip.pagable.size}');

      print('TripBloc: Calling PlanApiProvider.getMyPlans...');
      final List<Plan> myPlans = await PlanApiProvider(accessToken: accessToken).getMyPlans(
        reqParamsSearchTrip: reqParamsSearchTrip,
      );
      print('TripBloc: API call successful, received ${myPlans.length} plans');

      emitter(
        state.copyWith(
          myPlans: myPlans,
          getMyPlansStatus: LoadingStatus.loaded,
        ),
      );
      print('TripBloc: State updated to loaded with ${myPlans.length} plans');
    } catch (err) {
      print('TripBloc: Error in _onGetMyPlans: $err');
      print('TripBloc: Error type: ${err.runtimeType}');
      emitter(
        state.copyWith(
          getMyPlansErrMsg: 'Get my plans fail: $err',
          getMyPlansStatus: LoadingStatus.error,
        ),
      );
      print('TripBloc: State updated to error');
    }
    print('TripBloc: _onGetMyPlans called - END');
  }
}
