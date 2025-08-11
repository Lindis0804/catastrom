import 'package:dio/dio.dart';
import 'package:template/api/plan/dto/DeleteTrip.dart';
import 'package:template/api/plan/dto/ReqCreateTrip.dart';
import 'package:template/api/plan/dto/getSection.dart';
import 'package:template/common/utils/dio.utils.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/data/models/plan/plan.model.dart';
import 'package:template/api/plan/dto/ReqParamsSearchTrip.dart';
import 'package:template/api/plan/dto/ReqGetTimelineByTripCode.dart';
import 'package:template/api/plan/dto/ResGetTimelineByTripCode.dart';
import 'package:template/api/plan/dto/req_create_timeline.dart';
import 'package:template/api/plan/dto/ResCreateTimeline.dart';
import 'package:template/api/plan/dto/ReqUpdateTimeline.dart';
import 'package:template/api/plan/dto/ResUpdateTimeline.dart';
import 'package:template/api/plan/dto/timeline.dart';

class PlanApiProvider {
  String accessToken;
  late Dio dio;

  PlanApiProvider({required this.accessToken}) {
    dio = DioUtils.getDioClient(accessToken: accessToken);
  }

  Future<List<Plan>> getMyPlans(
      {required ReqParamsSearchTrip reqParamsSearchTrip}) async {
    Response res = await dio.get(
      '${EnvVariable.clientCustomerHost}/api/v1/trip/search',
      queryParameters: {
        'userId': reqParamsSearchTrip.userId,
        'startDate': reqParamsSearchTrip.startDate,
        'endDate': reqParamsSearchTrip.endDate,
        'pageable': {
          'page': reqParamsSearchTrip.pagable.page,
          'size': reqParamsSearchTrip.pagable.size,
          'sort': reqParamsSearchTrip.pagable.sort,
        }
      },
    );
    dynamic resData = res.data;
    print('🏖 [GET_MY_PLANS] resData: $resData');
    if (resData['responseCode'] != '0000') {
      throw Exception('Get my plans fail}');
    }
    List<dynamic> rawPlansData = resData['data']['content'];
    List<Plan> plans = rawPlansData
        .map((dynamic planData) => Plan.fromDynamic(planData))
        .toList();
    print('[GET_MY_PLANS] plans: $plans');
    return plans;
  }

  Future<Plan> createPlan({required ReqCreateTrip reqCreateTrip}) async {
    dynamic input = reqCreateTrip.toJson();

    Response res = await dio.post(
      '${EnvVariable.clientCustomerHost}/api/v1/trip/create',
      data: input,
    );

    String responseCode = res.data['responseCode'];
    if (responseCode == '' || responseCode != '0000') {
      throw Exception('Create trip fail.');
    }
    dynamic data = res.data['data'];
    Plan createdTrip = Plan.fromDynamic(data);

    return createdTrip;
  }

  Future<ResDeleteTrip> deletePlan(
      {required ReqDeleteTrip reqDeleteTrip}) async {
    Response res = await dio.delete(
        '${EnvVariable.clientCustomerHost}/api/v1/trip/delete',
        queryParameters: {'tripCode': reqDeleteTrip.tripCode});
    EDeleteTripStatus status;
    if (res.data['responseCode'] == '0000') {
      status = EDeleteTripStatus.SUCCESS;
    } else {
      status = EDeleteTripStatus.FAIL;
    }
    return ResDeleteTrip(status: status);
  }

  Future<ResGetSections> getSections(
      {required ReqGetSections reqGetSections}) async {
    ResGetSections sections = const ResGetSections(sections: [
      SectionItem(sectionId: '1', sectionName: 'Hà Tĩnh'),
      SectionItem(sectionId: '2', sectionName: 'Nghệ An'),
      SectionItem(sectionId: '3', sectionName: 'Quảng Bình'),
      SectionItem(sectionId: '4', sectionName: 'Quảng Trị'),
      SectionItem(sectionId: '5', sectionName: 'Thừa Thiên Huế'),
      SectionItem(sectionId: '6', sectionName: 'Đà Nẵng'),
    ]);
    return sections;
  }

  Future<ResGetTimelineByTripCode> getTimelineByTripCode({
    required ReqGetTimelineByTripCode reqGetTimelineByTripCode,
  }) async {
    print('[GET_TIMELINE_BY_TRIP_CODE] Starting request...');
    print(
        '[GET_TIMELINE_BY_TRIP_CODE] Trip code: ${reqGetTimelineByTripCode.tripCode}');

    Response res = await dio.get(
      '${EnvVariable.clientCustomerHost}/api/v1/trip/timeline/get-timeline-by-trip-code',
      queryParameters: {
        'code': reqGetTimelineByTripCode.tripCode,
      },
    );

    print('[GET_TIMELINE_BY_TRIP_CODE] Response received');
    print('[GET_TIMELINE_BY_TRIP_CODE] Response status: ${res.statusCode}');
    print('[GET_TIMELINE_BY_TRIP_CODE] Response data: ${res.data}');

    dynamic resData = res.data;

    if (resData['responseCode'] != '0000') {
      throw Exception(
          'Get timeline by trip code fail: ${resData["params"]["message"]}');
    }

    ResGetTimelineByTripCode timeline =
        ResGetTimelineByTripCode.fromJson(resData);
    print(
        '[GET_TIMELINE_BY_TRIP_CODE] Timeline parsed successfully: $timeline');

    return timeline;
  }

  Future<ResCreateTimeline> createTimeline({
    required ReqCreateTimeline reqCreateTimeline,
  }) async {
    print('[CREATE_TIMELINE] Starting request...');
    print('[CREATE_TIMELINE] Trip code: ${reqCreateTimeline.tripCode}');

    try {
      final requestData = reqCreateTimeline.toJson();
      print('[CREATE_TIMELINE] Request data: $requestData');

      Response res = await dio.post(
        '${EnvVariable.clientCustomerHost}/api/v1/trip/timeline/create',
        data: requestData,
      );

      print('[CREATE_TIMELINE] Response received');
      print('[CREATE_TIMELINE] Response status: ${res.statusCode}');
      print('[CREATE_TIMELINE] Response data: ${res.data}');

      dynamic resData = res.data;

      if (resData['responseCode'] != "0000") {
        throw Exception(
            'Create timeline fail: ${resData["params"]["message"]}');
      }

      ResCreateTimeline timeline = ResCreateTimeline.fromJson(resData);
      print('[CREATE_TIMELINE] Timeline created successfully: $timeline');

      return timeline;
    } catch (err) {
      print('[CREATE_TIMELINE] Error: $err');
      throw Exception('Create timeline fail: $err');
    }
  }

  Future<ResUpdateTimeline> updateTimeline({
    required ReqUpdateTimeline reqUpdateTimeline,
  }) async {
    try {
      print('[UPDATE_TIMELINE] Starting update timeline...');
      print('[UPDATE_TIMELINE] Request: $reqUpdateTimeline');

      // final response = await dio.put(
      //   '${EnvVariable.clientCustomerHost}/api/v1/trip/timeline/update',
      //   data: reqUpdateTimeline.toJson(),
      // );
      Response res = await dio.put(
        '${EnvVariable.clientCustomerHost}/api/v1/trip/timeline/update',
        data: reqUpdateTimeline.toJson(),
      );

      print('[UPDATE_TIMELINE] Response status: ${res.statusCode}');
      print('[UPDATE_TIMELINE] Response data: ${res.data}');

      dynamic resData = res.data;

      if (resData['responseCode'] != "0000") {
        throw Exception(
            'Update timeline fail: ${resData["params"]["message"]}');
      }

      ResUpdateTimeline timeline = ResUpdateTimeline.fromJson(resData);
      print('[UPDATE_TIMELINE] Timeline updated successfully: $timeline');

      return timeline;
    } catch (err) {
      print('[UPDATE_TIMELINE] Error: $err');
      throw Exception('Update timeline fail: $err');
    }
  }

  Future<Timeline> deleteTimeline({required int timelineId}) async {
    try {
      print('[DELETE_TIMELINE] Starting delete timeline...');
      print('[DELETE_TIMELINE] Timeline ID: $timelineId');

      Response res = await dio.delete(
        '${EnvVariable.clientCustomerHost}/api/v1/trip/timeline/delete/$timelineId',
      );

      print('[DELETE_TIMELINE] Response status: ${res.statusCode}');
      print('[DELETE_TIMELINE] Response data: ${res.data}');

      dynamic resData = res.data;

      if (resData['responseCode'] != '0000') {
        throw Exception(
            'Delete timeline fail: ${resData["params"]["message"]}');
      }

      // Parse the returned timeline data
      Timeline deletedTimeline = Timeline.fromJson(resData['data']);
      print(
          '[DELETE_TIMELINE] Timeline deleted successfully: $deletedTimeline');

      return deletedTimeline;
    } catch (err) {
      print('[DELETE_TIMELINE] Error: $err');
      throw Exception('Delete timeline fail: $err');
    }
  }
}
