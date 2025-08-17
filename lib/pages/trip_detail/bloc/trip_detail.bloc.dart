import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/plan/plan.model.dart';
import 'package:template/api/plan/provider.dart';
import 'package:template/api/plan/dto/ReqGetTimelineByTripCode.dart';
import 'package:template/api/plan/dto/timeline.dart';

part 'trip_detail.event.dart';
part 'trip_detail.state.dart';

class TripDetailBloc extends Bloc<TripDetailEvent, TripDetailState> {
  TripDetailBloc() : super(TripDetailState.initialize()) {
    on<SetSelectedPlan>(_onSetSelectedPlan);
    on<ClearSelectedPlan>(_onClearSelectedPlan);
    on<GetTimelineByTripCode>(_onGetTimelineByTripCode);
    on<DeleteTimeline>(_onDeleteTimeline);
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

      // Create request
      final request = ReqGetTimelineByTripCode(tripCode: event.tripCode);

      // Call API
      final response = await PlanApiProvider(accessToken: accessToken)
          .getTimelineByTripCode(reqGetTimelineByTripCode: request);

      // Always emit loaded state, even if timelines list is empty
      emitter(
        state.copyWith(
          timelines: response.timelines, // This can be an empty list now
          timelineStatus: LoadingStatus.loaded,
          timelineErrorMessage: null,
        ),
      );
    } catch (err) {
      print('[TRIP_DETAIL_BLOC] Error getting timeline: $err');

      // Handle specific error cases
      String errorMessage;
      if (err.toString().contains('type \'Null\' is not a subtype')) {
        // This means the API returned null for timelines, so we should show empty state
        print('[TRIP_DETAIL_BLOC] Timeline data is null, showing empty state');
        emitter(
          state.copyWith(
            timelines: <Timeline>[], // Set empty list instead of error
            timelineStatus: LoadingStatus.loaded,
            timelineErrorMessage: null,
          ),
        );
        return;
      } else if (err.toString().contains('Access token not found')) {
        errorMessage = 'Phiên đăng nhập hết hạn. Vui lòng đăng nhập lại.';
      } else {
        errorMessage = 'Lỗi khi tải lịch trình. Vui lòng thử lại.';
      }

      emitter(
        state.copyWith(
          timelineStatus: LoadingStatus.error,
          timelineErrorMessage: errorMessage,
        ),
      );
    }
  }

  Future<void> _onDeleteTimeline(
    DeleteTimeline event,
    Emitter<TripDetailState> emitter,
  ) async {
    print('[TRIP_DETAIL_BLOC] Deleting timeline with ID: ${event.timelineId}');

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

      // Call API to delete timeline
      final deletedTimeline = await PlanApiProvider(accessToken: accessToken)
          .deleteTimeline(timelineId: event.timelineId);

      print(
          '[TRIP_DETAIL_BLOC] Timeline deleted successfully: $deletedTimeline');

      // After successful delete, automatically refresh the timeline list
      final tripCode = state.selectedPlan?.tripCode;
      if (tripCode != null) {
        print('[TRIP_DETAIL_BLOC] Refreshing timeline list after delete');

        // Create request
        final request = ReqGetTimelineByTripCode(tripCode: tripCode);

        // Fetch updated timeline list
        final response = await PlanApiProvider(accessToken: accessToken)
            .getTimelineByTripCode(reqGetTimelineByTripCode: request);

        // Emit success state with updated timeline list
        emitter(
          state.copyWith(
            timelines: response.timelines,
            timelineStatus: LoadingStatus.loaded,
            timelineErrorMessage: null,
          ),
        );
      } else {
        // If no trip code available, just emit success
        emitter(
          state.copyWith(
            timelineStatus: LoadingStatus.loaded,
            timelineErrorMessage: null,
          ),
        );
      }
    } catch (err) {
      print('[TRIP_DETAIL_BLOC] Error deleting timeline: $err');

      String errorMessage = 'Lỗi khi xóa lịch trình. Vui lòng thử lại.';
      if (err.toString().contains('Access token not found')) {
        errorMessage = 'Phiên đăng nhập hết hạn. Vui lòng đăng nhập lại.';
      }

      emitter(
        state.copyWith(
          timelineStatus: LoadingStatus.error,
          timelineErrorMessage: errorMessage,
        ),
      );
    }
  }
}
