import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:template/api/auth/response.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/pages/login/dto/LoginUser.dto.dart';

class AuthApiProvider {
  Dio dio;
  AuthApiProvider({required this.dio});

  Future<ResLogin> login({required LoginUser data}) async {
    Response res = await dio.post('${EnvVariable.clientCustomerHost}/api/login',
        data: data);
    if (res.statusCode == 200) {
      String accessToken = res.data['data']['accessToken'] ?? '',
          refreshToken = res.data['data']['refreshToken'] ?? '';
      Map<String, dynamic> user = res.data['data']['user'] ?? {};
      String strUser = jsonEncode(user);
      return ResLogin(
          accessToken: accessToken,
          strUser: strUser,
          refreshToken: refreshToken);
    } else {
      throw Exception('Login failed');
    }
  }
}
