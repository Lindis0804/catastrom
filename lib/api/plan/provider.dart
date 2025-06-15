import 'package:dio/dio.dart';
import 'package:template/api/plan/dto/DeleteTrip.dart';
import 'package:template/api/plan/dto/ReqCreateTrip.dart';
import 'package:template/api/plan/dto/getSection.dart';
import 'package:template/common/constants/api.dart';
import 'package:template/common/utils/dio.utils.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/data/models/plan/plan.model.dart';
import 'package:template/api/plan/dto/ReqParamsSearchTrip.dart';

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
    if (resData["responseCode"] != "0000") {
      throw Exception('Get my plans fail}');
    }
    List<dynamic> rawPlansData = resData['data']['content'];
    List<Plan> plans = rawPlansData
        .map((dynamic planData) => Plan.fromDynamic(planData))
        .toList();
    print('🏖 [GET_MY_PLANS] plans: $plans');
    return plans;
  }

  Future<ResCreateTrip> createPlan(
      {required ReqCreateTrip reqCreateTrip}) async {
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
    ResCreateTrip createdTrip = ResCreateTrip.fromDynamic(data);

    return createdTrip;
  }

  Future<ResDeleteTrip> deletePlan(
      {required ReqDeleteTrip reqDeleteTrip}) async {
    Response res = await dio.delete(
        '${EnvVariable.clientCustomerHost}/api/v1/trip/delete',
        queryParameters: {'tripCode': reqDeleteTrip.tripCode});
    EDeleteTripStatus status;
    if (res.data["responseCode"] == "0000") {
      status = EDeleteTripStatus.SUCCESS;
    } else {
      status = EDeleteTripStatus.FAIL;
    }
    return ResDeleteTrip(status: status);
  }

  Future<ResGetSections> getSections(
      {required ReqGetSections reqGetSections}) async {
    ResGetSections sections = const ResGetSections(sections: [
      SectionItem(sectionId: "1", sectionName: "Hà Tĩnh"),
      SectionItem(sectionId: "2", sectionName: "Nghệ An"),
      SectionItem(sectionId: "3", sectionName: "Quảng Bình"),
      SectionItem(sectionId: "4", sectionName: "Quảng Trị"),
      SectionItem(sectionId: "5", sectionName: "Thừa Thiên Huế"),
      SectionItem(sectionId: '6', sectionName: 'Đà Nẵng'),
    ]);
    return sections;
  }
}
