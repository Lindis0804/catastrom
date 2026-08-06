import 'package:dio/dio.dart';
import 'package:template/common/constants/api.dart';
import 'package:template/common/utils/token_refresh_interceptor.dart';

class DioUtils {
  static Dio getDioClient({String? accessToken}) {
    Dio dio =
        Dio(BaseOptions(connectTimeout: Api.connectionTimeoutSeconds * 1000));
    if (accessToken != null) {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
    }
    dio.interceptors.add(TokenRefreshInterceptor());
    return dio;
  }

  static bool isSuccessfulRequest(int status) {
    if (status >= 200 && status < 300) {
      return true;
    }
    return false;
  }
}
