import 'package:template/data/models/user/user.model.dart';

class SignInResponse {
  final String accessToken;
  final String refreshToken;
  final User user;

  const SignInResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory SignInResponse.fromDynamic(dynamic raw) {
    return SignInResponse(
      accessToken: raw['accessToken'] ?? '',
      refreshToken: raw['refreshToken'] ?? '',
      user: User.fromJson(raw['user'] ?? {}),
    );
  }
}
