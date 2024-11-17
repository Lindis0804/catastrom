import 'package:dio/dio.dart';
import 'package:template/common/constants/api.dart';

class DioUtils {
  static Dio getDioClient({String? accessToken}) {
    Dio dio =
        Dio(BaseOptions(connectTimeout: Api.connectionTimeoutSeconds * 1000));
    if (accessToken != null) {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return dio;
  }

  static bool isSuccessfulRequest(int status) {
    if (status >= 200 && status < 300) {
      return true;
    }
    return false;
  }
}
