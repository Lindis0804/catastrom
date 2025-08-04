import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/plan/plan.model.dart';
import 'package:template/api/plan/provider.dart';
import 'package:template/api/plan/dto/ReqGetTimelineByTripCode.dart';
import 'package:template/api/plan/dto/Timeline.dart';

part 'trip_detail.event.dart';
part 'trip_detail.state.dart';

class TripDetailBloc extends Bloc<TripDetailEvent, TripDetailState> {
  TripDetailBloc() : super(TripDetailState.initialize()) {
    on<SetSelectedPlan>(_onSetSelectedPlan);
    on<ClearSelectedPlan>(_onClearSelectedPlan);
    on<GetTimelineByTripCode>(_onGetTimelineByTripCode);
  }

  void _onSetSelectedPlan(
    SetSelectedPlan event,
    Emitter<TripDetailState> emitter,
  ) {
    emitter(
      state.copyWith(
        selectedPlan: event.plan,
        status: LoadingStatus.loaded,
        errorMessage: null,
      ),
    );
  }

  void _onClearSelectedPlan(
    ClearSelectedPlan event,
    Emitter<TripDetailState> emitter,
  ) {
    emitter(
      state.copyWith(
        selectedPlan: null,
        status: LoadingStatus.initialize,
        errorMessage: null,
        timelines: null,
        timelineStatus: LoadingStatus.initialize,
        timelineErrorMessage: null,
      ),
    );
  }

  Future<void> _onGetTimelineByTripCode(
    GetTimelineByTripCode event,
    Emitter<TripDetailState> emitter,
  ) async {
    print(
        '[TRIP_DETAIL_BLOC] Getting timeline for trip code: ${event.tripCode}');

    emitter(
      state.copyWith(
        timelineStatus: LoadingStatus.loading,
        timelineErrorMessage: null,
      ),
    );

    try {
      // Get access token
      final String? accessToken =
          await SharedPreferencesManager.getString(SPKeys.ACCESS_TOKEN);
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      print('[TRIP_DETAIL_BLOC] Access token retrieved, calling API...');

      // Create request
      final request = ReqGetTimelineByTripCode(tripCode: event.tripCode);

      // Call API
      final response = await PlanApiProvider(accessToken: accessToken)
          .getTimelineByTripCode(reqGetTimelineByTripCode: request);

      print(
          '[TRIP_DETAIL_BLOC] Timeline API call successful, timelines count: ${response.timelines.length}');

      emitter(
        state.copyWith(
          timelines: response.timelines,
          timelineStatus: LoadingStatus.loaded,
          timelineErrorMessage: null,
        ),
      );
    } catch (err) {
      print('[TRIP_DETAIL_BLOC] Error getting timeline: $err');
      emitter(
        state.copyWith(
          timelineStatus: LoadingStatus.error,
          timelineErrorMessage: 'Lỗi khi tải lịch trình: $err',
        ),
      );
    }
  }
}
