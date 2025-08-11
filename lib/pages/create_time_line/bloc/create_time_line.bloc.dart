import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/plan/dto/req_create_timeline.dart';
import 'package:template/api/plan/dto/ReqUpdateTimeline.dart';
import 'package:template/api/plan/provider.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/pages/create_time_line/bloc/create_time_line.event.dart';
import 'package:template/pages/create_time_line/bloc/create_time_line.state.dart';

class CreateTimelineBloc
    extends Bloc<CreateTimelineEvent, CreateTimelineState> {
  CreateTimelineBloc() : super(const CreateTimelineState()) {
    on<CreateTimelineSubmitEvent>(_onCreateTimeline);
    on<UpdateTimelineSubmitEvent>(_onUpdateTimeline);
  }

  Future<void> _onCreateTimeline(
    CreateTimelineSubmitEvent event,
    Emitter<CreateTimelineState> emitter,
  ) async {
    try {
      print('[CREATE_TIMELINE_BLOC] Starting create timeline...');

      emitter(state.copyWith(createTimelineStatus: LoadingStatus.loading));

      // Get access token
      final String? accessToken =
          await SharedPreferencesManager.getString(SPKeys.ACCESS_TOKEN);
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      print('[CREATE_TIMELINE_BLOC] Access token retrieved');

      // Create timeline request with the new structure
      final reqCreateTimeline = ReqCreateTimeline(
        tripCode: event.tripCode,
        locationCode: event.locationCode,
        activityCode: event.activityCode,
        startTime: event.startTime,
        endTime: event.endTime,
        subTimeLine: [],
      );

      print('[CREATE_TIMELINE_BLOC] Request created: $reqCreateTimeline');

      // Call API
      final timeline =
          await PlanApiProvider(accessToken: accessToken).createTimeline(
        reqCreateTimeline: reqCreateTimeline,
      );

      print('[CREATE_TIMELINE_BLOC] Timeline created successfully: $timeline');

      emitter(state.copyWith(createTimelineStatus: LoadingStatus.loaded));
    } catch (err) {
      print('[CREATE_TIMELINE_BLOC] Error: $err');

      // Clean up error message for better user experience
      String cleanErrorMessage = _extractErrorMessage(err.toString());

      emitter(state.copyWith(
        createTimelineStatus: LoadingStatus.error,
        createTimelineErrMsg: cleanErrorMessage,
      ));
    }
  }

  Future<void> _onUpdateTimeline(
    UpdateTimelineSubmitEvent event,
    Emitter<CreateTimelineState> emitter,
  ) async {
    try {
      print('[CREATE_TIMELINE_BLOC] Starting update timeline...');

      emitter(state.copyWith(createTimelineStatus: LoadingStatus.loading));

      // Get access token
      final String? accessToken =
          await SharedPreferencesManager.getString(SPKeys.ACCESS_TOKEN);
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      print('[CREATE_TIMELINE_BLOC] Access token retrieved');

      // Create timeline update request
      final reqUpdateTimeline = ReqUpdateTimeline(
        id: event.timelineId,
        tripCode: event.tripCode,
        locationCode: event.locationCode,
        activityCode: event.activityCode,
        startTime: event.startTime,
        endTime: event.endTime,
        subTimeline: [], // Empty list for now, can be extended later
      );

      print(
          '[CREATE_TIMELINE_BLOC] Update request created: $reqUpdateTimeline');

      // Call API
      final timeline =
          await PlanApiProvider(accessToken: accessToken).updateTimeline(
        reqUpdateTimeline: reqUpdateTimeline,
      );

      print('[CREATE_TIMELINE_BLOC] Timeline updated successfully: $timeline');

      emitter(state.copyWith(createTimelineStatus: LoadingStatus.loaded));
    } catch (err) {
      print('[CREATE_TIMELINE_BLOC] Error: $err');

      // Clean up error message for better user experience
      String cleanErrorMessage = _extractErrorMessage(err.toString());

      emitter(state.copyWith(
        createTimelineStatus: LoadingStatus.error,
        createTimelineErrMsg: cleanErrorMessage,
      ));
    }
  }

  // Helper method to extract clean error messages
  String _extractErrorMessage(String errorString) {
    // Remove redundant prefixes and stack traces
    String cleanError = errorString
        .replaceAll('Exception: Create timeline fail: ', '')
        .replaceAll('Exception: Update timeline fail: ', '')
        .replaceAll('Exception: ', '');

    // If the error is too long or contains technical details, truncate it
    if (cleanError.length > 200 ||
        cleanError.contains('JDBC') ||
        cleanError.contains('SQL')) {
      // Extract the most relevant part
      if (cleanError.contains('Table') &&
          cleanError.contains('doesn\'t exist')) {
        return 'Database table does not exist - system maintenance required';
      } else if (cleanError.contains('Access token')) {
        return 'Authentication failed - please login again';
      } else {
        return 'System error occurred';
      }
    }

    return cleanError;
  }
}
