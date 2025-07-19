import 'package:template/api/plan/dto/Timeline.dart';
import 'package:template/api/plan/dto/SubTimeline.dart';

// TODO: REMOVE THIS FILE WHEN REAL API IS WORKING
// This is for demo purposes only
class TimelineMockData {
  static const bool ENABLE_MOCK = true; // Set to false to disable mock data

  static List<Timeline> getMockTimelines() {
    return [
      Timeline(
        id: 1,
        locationCode: "HN001",
        activityCode: "FLIGHT",
        startTime: DateTime(2025, 7, 20, 6, 0),
        endTime: DateTime(2025, 7, 20, 8, 30),
        subTimeLine: [
          SubTimeline(
            locationCode: "NOI_BAI",
            activityCode: "CHECK_IN",
            startTime: DateTime(2025, 7, 20, 6, 0),
            endTime: DateTime(2025, 7, 20, 7, 0),
          ),
          SubTimeline(
            locationCode: "NOI_BAI",
            activityCode: "BOARDING",
            startTime: DateTime(2025, 7, 20, 7, 30),
            endTime: DateTime(2025, 7, 20, 8, 30),
          ),
        ],
      ),
      Timeline(
        id: 2,
        locationCode: "DA_NANG",
        activityCode: "HOTEL",
        startTime: DateTime(2025, 7, 20, 10, 0),
        endTime: DateTime(2025, 7, 20, 12, 0),
        subTimeLine: [
          SubTimeline(
            locationCode: "CITY_CENTER",
            activityCode: "CHECK_IN_HOTEL",
            startTime: DateTime(2025, 7, 20, 10, 0),
            endTime: DateTime(2025, 7, 20, 11, 0),
          ),
          SubTimeline(
            locationCode: "HOTEL_ROOM",
            activityCode: "REST",
            startTime: DateTime(2025, 7, 20, 11, 0),
            endTime: DateTime(2025, 7, 20, 12, 0),
          ),
        ],
      ),
      Timeline(
        id: 3,
        locationCode: "HOI_AN",
        activityCode: "SIGHTSEEING",
        startTime: DateTime(2025, 7, 20, 14, 0),
        endTime: DateTime(2025, 7, 20, 18, 0),
        subTimeLine: [
          SubTimeline(
            locationCode: "OLD_QUARTER",
            activityCode: "WALKING_TOUR",
            startTime: DateTime(2025, 7, 20, 14, 0),
            endTime: DateTime(2025, 7, 20, 16, 0),
          ),
          SubTimeline(
            locationCode: "JAPANESE_BRIDGE",
            activityCode: "PHOTO_TAKING",
            startTime: DateTime(2025, 7, 20, 16, 30),
            endTime: DateTime(2025, 7, 20, 17, 30),
          ),
          SubTimeline(
            locationCode: "NIGHT_MARKET",
            activityCode: "SHOPPING",
            startTime: DateTime(2025, 7, 20, 17, 30),
            endTime: DateTime(2025, 7, 20, 18, 0),
          ),
        ],
      ),
      Timeline(
        id: 4,
        locationCode: "DA_NANG_BEACH",
        activityCode: "DINING",
        startTime: DateTime(2025, 7, 20, 19, 0),
        endTime: DateTime(2025, 7, 20, 21, 0),
        subTimeLine: [
          SubTimeline(
            locationCode: "SEAFOOD_RESTAURANT",
            activityCode: "DINNER",
            startTime: DateTime(2025, 7, 20, 19, 0),
            endTime: DateTime(2025, 7, 20, 20, 30),
          ),
          SubTimeline(
            locationCode: "BEACH_WALK",
            activityCode: "EVENING_STROLL",
            startTime: DateTime(2025, 7, 20, 20, 30),
            endTime: DateTime(2025, 7, 20, 21, 0),
          ),
        ],
      ),
      Timeline(
        id: 5,
        locationCode: "BA_NA_HILLS",
        activityCode: "ADVENTURE",
        startTime: DateTime(2025, 7, 21, 8, 0),
        endTime: DateTime(2025, 7, 21, 17, 0),
        subTimeLine: [
          SubTimeline(
            locationCode: "CABLE_CAR",
            activityCode: "TRANSPORTATION",
            startTime: DateTime(2025, 7, 21, 8, 0),
            endTime: DateTime(2025, 7, 21, 9, 0),
          ),
          SubTimeline(
            locationCode: "GOLDEN_BRIDGE",
            activityCode: "SIGHTSEEING",
            startTime: DateTime(2025, 7, 21, 9, 30),
            endTime: DateTime(2025, 7, 21, 12, 0),
          ),
          SubTimeline(
            locationCode: "FRENCH_VILLAGE",
            activityCode: "LUNCH",
            startTime: DateTime(2025, 7, 21, 12, 0),
            endTime: DateTime(2025, 7, 21, 13, 30),
          ),
          SubTimeline(
            locationCode: "FANTASY_PARK",
            activityCode: "GAMES",
            startTime: DateTime(2025, 7, 21, 14, 0),
            endTime: DateTime(2025, 7, 21, 16, 0),
          ),
          SubTimeline(
            locationCode: "CABLE_CAR",
            activityCode: "RETURN",
            startTime: DateTime(2025, 7, 21, 16, 0),
            endTime: DateTime(2025, 7, 21, 17, 0),
          ),
        ],
      ),
    ];
  }
}
