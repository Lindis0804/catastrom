import 'package:template/data/models/user/user.model.dart';

class SignInResponse {
  final String accessToken;
  final User user;

  const SignInResponse({required this.accessToken, required this.user});

  factory SignInResponse.fromDynamic(dynamic raw) {
    return SignInResponse(
      accessToken: raw['accessToken'] ?? '',
      user: User.fromJson(raw['user'] ?? {}),
    );
  }
}
