import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Api {
  //static const host = 'http://192.168.1.4:2000';
  // static const host = 'http://dev.techlinkvn.com:59070';
  static String host = 'http://localhost:2000';
  static String signUp = '$host/auth/sign-up';
  static String login = '$host/auth/login';
  static String verifySignUpCode = '$host/auth/verify-sign-up-code';
  static String updateUser = '$host/users/update-my-profile';
  static String createDocument = '$host/documents';
  static String downloadVersion({required int versionId}) {
    return '$host/versions/$versionId/download';
  }

  static int connectionTimeoutSeconds = 5;
}
