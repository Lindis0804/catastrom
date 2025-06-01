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
      String accessToken = res.data['data']['accessToken'] ?? '';
      return ResLogin(accessToken: accessToken);
    } else {
      throw Exception('Login failed');
    }
  }
}
