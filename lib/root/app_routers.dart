import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/pages/forgot_password/forgot_password.screen.dart';
import 'package:template/pages/manage/manage.screen.dart';
import 'package:template/pages/login/login.screen.dart';
import 'package:template/pages/new_plan/screen/new_plan.screen.dart';
import 'package:template/pages/profile/profile.screen.dart';
import 'package:template/pages/signup/signup.screen.dart';
import 'package:template/pages/splash/splash.screen.dart';

import '../pages/create_time_line/create_timeline.screen.dart';
import '../pages/create_time_line/models/create_timeline_arguments.dart';
import '../pages/trip_detail/bloc/trip_detail.bloc.dart';
import '../pages/trip_detail/trip_detail.screen.dart';

abstract class AppRouters {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String setting = '/setting';
  static const String newPlan = '/new-plan';
  static const String tripDetail = '/trip-detail';
  static const String createTimeline = '/create-timeline';

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

      case newPlan:
        return MaterialPageRoute(builder: (_) => const NewPlanScreen());

      case tripDetail:
        final tripDetailBloc = setting.arguments as TripDetailBloc?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: tripDetailBloc ?? TripDetailBloc(),
            child: const TripDetailScreen(),
          ),
        );

      case createTimeline:
        // Handle both old String arguments and new CreateTimelineArguments
        if (setting.arguments is CreateTimelineArguments) {
          final args = setting.arguments as CreateTimelineArguments;
          return MaterialPageRoute(
            builder: (_) => CreateTimelineScreen.fromArguments(args),
          );
        } else {
          // Backward compatibility for String tripCode
          final String? tripCode = setting.arguments as String?;
          return MaterialPageRoute(
            builder: (_) => CreateTimelineScreen(tripCode: tripCode),
          );
        }

      case profile:
        Map<String, dynamic> args = setting.arguments as Map<String, dynamic>;
        int? userId = args['userId'];
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(
            userId: userId,
          ),
        );

      default:
        return null;
    }
  }
}
