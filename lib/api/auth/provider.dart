import 'package:dio/dio.dart';
import 'package:template/common/utils/dio.utils.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/data/models/auth/sign_in_response.model.dart';

class AuthApiProvider {
  late Dio dio;

  AuthApiProvider() {
    dio = DioUtils.getDioClient();
  }

  Future<SignInResponse> signIn({
    required String username,
    required String password,
  }) async {
    Response res = await dio.post(
      '${EnvVariable.clientCustomerHost}/auth/sign-in',
      data: {'username': username, 'password': password},
    );
    dynamic resData = res.data;
    if (resData['status'] != 200) {
      throw Exception(resData['error'] ?? 'Sign in failed');
    }
    return SignInResponse.fromDynamic(resData['data']);
  }

  Future<SignInResponse> signUp({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    Response res = await dio.post(
      '${EnvVariable.clientCustomerHost}/auth/sign-up',
      data: {
        'username': username,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      },
    );
    dynamic resData = res.data;
    if (resData['status'] != 200) {
      throw Exception(resData['error'] ?? 'Sign up failed');
    }
    return SignInResponse.fromDynamic(resData['data']);
  }

  Future<String> refreshToken({required String refreshToken}) async {
    Response res = await dio.post(
      '${EnvVariable.clientCustomerHost}/auth/refresh-token',
      data: {'refreshToken': refreshToken},
    );
    dynamic resData = res.data;
    if (resData['status'] != 200) {
      throw Exception(resData['error'] ?? 'Refresh token failed');
    }
    return resData['data']['accessToken'] ?? '';
  }
}
