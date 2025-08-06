import 'package:template/api/plan/dto/timeline.dart';
import 'package:template/api/plan/dto/sub_time_line_DTO.dart';

// TODO: REMOVE THIS FILE WHEN REAL API IS WORKING
// This is for demo purposes only
class TimelineMockData {
  static const bool enableMock = true; // Set to false to disable mock data

  static List<Timeline> getMockTimelines() {
    return [
      Timeline(
        id: 1,
        tripCode: 'HN001',
        locationCode: 'HN001',
        activityCode: 'FLIGHT',
        startTime: DateTime(2025, 7, 20, 6, 0),
        endTime: DateTime(2025, 7, 20, 8, 30),
        subTimeLine: [
          SubTimeLineDTO(
            id: 11,
            locationCode: 'NOI_BAI',
            activityCode: 'CHECK_IN',
            startTime: DateTime(2025, 7, 20, 6, 0),
            endTime: DateTime(2025, 7, 20, 7, 0),
            subTimeLine: [],
          ),
          SubTimeLineDTO(
            id: 12,
            locationCode: 'NOI_BAI',
            activityCode: 'BOARDING',
            startTime: DateTime(2025, 7, 20, 7, 30),
            endTime: DateTime(2025, 7, 20, 8, 0),
            subTimeLine: [],
          ),
        ],
      ),
    ];
  }
}
