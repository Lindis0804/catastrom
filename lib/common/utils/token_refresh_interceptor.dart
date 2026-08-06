import 'package:dio/dio.dart';
import 'package:template/api/auth/provider.dart';
import 'package:template/common/utils/share_preferences.dart';

// Runs whenever any request comes back 401 (access token expired/invalid):
// tries to mint a new access token via /auth/refresh-token, then replays the
// original request once with it. QueuedInterceptor so concurrent 401s (e.g.
// Home's parallel fetches) share a single refresh call instead of each firing
// their own.
class TokenRefreshInterceptor extends QueuedInterceptor {
  static const List<String> _noRefreshPaths = [
    '/auth/sign-in',
    '/auth/sign-up',
    '/auth/refresh-token',
  ];

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    bool isAuthEndpoint = _noRefreshPaths
        .any((path) => err.requestOptions.path.contains(path));
    if (err.response?.statusCode != 401 || isAuthEndpoint) {
      return handler.next(err);
    }

    try {
      String refreshToken = await SharedPreferencesManager.getRefreshToken();
      if (refreshToken.isEmpty) {
        return handler.next(err);
      }

      String newAccessToken =
          await AuthApiProvider().refreshToken(refreshToken: refreshToken);
      if (newAccessToken.isEmpty) {
        return handler.next(err);
      }
      await SharedPreferencesManager.saveString(
          SPKeys.ACCESS_TOKEN, newAccessToken);

      RequestOptions retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';

      Response response = await Dio().fetch(retryOptions);
      return handler.resolve(response);
    } catch (e) {
      // Refresh token itself is invalid/expired: clear both tokens so the
      // next app launch's auth check sends the user back to sign-in.
      await SharedPreferencesManager.removeToken(SPKeys.ACCESS_TOKEN);
      await SharedPreferencesManager.removeToken(SPKeys.REFRESH_TOKEN);
      return handler.next(err);
    }
  }
}
