import 'package:dio/dio.dart';
import 'package:template/api/plan/dto/ReqCreateTrip.dart';
import 'package:template/api/plan/dto/getSection.dart';
import 'package:template/common/constants/api.dart';
import 'package:template/common/utils/dio.utils.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/data/models/plan/plan.model.dart';

class PlanApiProvider {
  String accessToken;
  late Dio dio;

  PlanApiProvider({required this.accessToken}) {
    dio = DioUtils.getDioClient(accessToken: accessToken);
  }

  Future<List<Plan>> getMyPlans({required int userId}) async {
    List<Plan> plans = [
      Plan(
          id: 1,
          name: 'Du hí Hà Tĩnh',
          address: 'Hà Tĩnh',
          startTime: DateTime(2024, 11, 17),
          endTime: DateTime(2024, 11, 20),
          imageUrl:
              'https://images.baoangiang.com.vn/image/fckeditor/upload/2023/20231102/images/T11.jpg'),
      Plan(
          id: 2,
          name: 'Tắm biển cửa lò',
          address: 'Cửa Lò, Nghệ An',
          startTime: DateTime(2024, 10, 17),
          endTime: DateTime(2024, 10, 21),
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/6/61/Cualovedem.jpg')
    ];

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
