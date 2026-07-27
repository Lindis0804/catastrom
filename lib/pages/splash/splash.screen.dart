import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/splash_status.enum.dart';
import 'package:template/generated/assets.gen.dart';
import 'package:template/pages/splash/bloc/splash.bloc.dart';
import 'package:template/root/app_routers.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => SplashBloc(),
        child: BlocListener<SplashBloc, SplashState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: _listener,
          child: const _SplashScreenView(),
        ),
      );

  void _listener(
    BuildContext context,
    SplashState state,
  ) {
    switch (state.status) {
      case SplashStatus.authenticated:
        Navigator.of(context).pushReplacementNamed(AppRouters.home);
        break;
      case SplashStatus.unauthenticated:
      default:
        Navigator.of(context).pushReplacementNamed(AppRouters.login);
        break;
    }
  }
}

class _SplashScreenView extends StatelessWidget {
  const _SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Assets.images.splashImage.provider(),
                  fit: BoxFit.fitHeight),
            ),
          ),
        ),
      );
}
