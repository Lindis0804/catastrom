import 'package:dio/dio.dart';
import 'package:template/api/place/dto/location.dart';
import 'package:template/api/place/dto/recommended_place.dart';
import 'package:template/common/utils/dio.utils.dart';
import 'package:template/common/utils/env.dart';

class PlaceApiProvider {
  String accessToken;
  late Dio dio;

  PlaceApiProvider({required this.accessToken}) {
    dio = DioUtils.getDioClient(accessToken: accessToken);
  }

  Future<List<RecommendedPlace>> getRecommenedPlaces(
      {required int userId}) async {
    List<RecommendedPlace> recommenedPlaces = [
      const RecommendedPlace(
          latitude: 1,
          longtitude: 1,
          name: 'Xụm Lào',
          address: 'Nghi Xuân, Hà Tĩnh',
          businessType: 'Ăn uống',
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1PAx0C0DsjIo-gJs8kTel6enkkcbSB8Z7QQ&s'),
      const RecommendedPlace(
          latitude: 2,
          longtitude: 2,
          name: 'Cafe Tự Do',
          address: '30 Trần Hưng Đạo, Hà Nội',
          businessType: 'Ăn uống',
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0mNTYDd1aOHlptvhJF3oFWmRIVfkC7cyqzA&s')
    ];
    return recommenedPlaces;
  }

  Future<List<Location>> getLocations(
      {required String keyword, int page = 0, int size = 10}) async {
    try {
      final response = await dio.get(
          '${EnvVariable.clientCustomerHost}/api/v1/location/search',
          queryParameters: {
            'keyword': keyword,
            'page': page,
            'size': size,
          });
      if (response.statusCode == 200) {
        List<Location> locations = (response.data['data']['content'] as List)
            .map((location) => Location.fromJson(location))
            .toList();
        return locations;
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      throw Exception('Failed to load locations: $e');
    }
  }
}
