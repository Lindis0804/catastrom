import 'package:flutter/material.dart';
import 'package:template/pages/forgot_password/forgot_password.screen.dart';
import 'package:template/pages/manage/manage.screen.dart';
import 'package:template/pages/login/login.screen.dart';
import 'package:template/pages/signup/signup.screen.dart';
import 'package:template/pages/splash/splash.screen.dart';

abstract class AppRouters {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String setting = '/setting';

  static Route? onGenRoutes(RouteSettings setting) {
    switch (setting.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case home:
        return MaterialPageRoute(
          builder: (_) => const ManageScreen(),
        );

      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      default:
        return null;
    }
  }
}
