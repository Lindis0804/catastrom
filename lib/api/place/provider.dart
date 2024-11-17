import 'package:dio/dio.dart';
import 'package:template/api/place/dto/recommended_place.dart';
import 'package:template/common/utils/dio.utils.dart';

class PlaceApiProvider {
  String accessToken;
  late Dio dio;

  PlaceApiProvider({required this.accessToken}) {
    dio = DioUtils.getDioClient(accessToken: accessToken);
  }

  Future<List<RecommendedPlace>> getRecommenedPlaces(
      {required int userId}) async {
    List<RecommendedPlace> recommenedPlaces = [
      RecommendedPlace(
          latitude: 1,
          longtitude: 1,
          name: 'Xụm Lào',
          address: 'Nghi Xuân, Hà Tĩnh',
          businessType: 'Ăn uống',
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1PAx0C0DsjIo-gJs8kTel6enkkcbSB8Z7QQ&s'),
      RecommendedPlace(
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
}
