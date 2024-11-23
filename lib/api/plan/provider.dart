import 'package:dio/dio.dart';
import 'package:template/api/plan/dto/CreatePlanDto.dart';
import 'package:template/common/constants/api.dart';
import 'package:template/common/utils/dio.utils.dart';
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

  Future<Plan> createPlan({required CreatePlanDto createPlanDto}) async {
    Response res =
        await dio.post('${Api.host}/api/v1/plan/create', data: createPlanDto);

    Plan createdPlan = Plan.fromDynamic(res.data['data']);

    return createdPlan;
  }
}
