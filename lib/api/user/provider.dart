import 'package:template/common/utils/dio.utils.dart';
import 'package:dio/dio.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/data/models/user/user.model.dart';

class UserApiProvider {
  String accessToken;
  late Dio dio;

  UserApiProvider({required this.accessToken}) {
    dio = DioUtils.getDioClient(accessToken: accessToken);
  }

  Future<User> getUser({required int userId}) async {
    User user = User(
        id: 1,
        firstName: 'Lê Đình',
        lastName: 'Hiếu',
        phone: '0819019699',
        username: 'hieule',
        avatar: EnvVariable().defaultAvatar,
        cover: EnvVariable().defaultCover);
    return user;
  }
}
