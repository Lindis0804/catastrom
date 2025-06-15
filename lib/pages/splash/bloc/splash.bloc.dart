import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:template/common/enums/splash_status.enum.dart';
import 'package:template/common/utils/share_preferences.dart';

part 'splash.event.dart';
part 'splash.state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc()
      : super(
          const SplashState.initial(),
        ) {
    on<SplashStarted>(_onCheckAuthentication);
    on<SplashStatusChanged>(_onStatusChanged);
    add(const SplashStarted());
  }

  Future<void> _onStatusChanged(
    SplashEvent event,
    Emitter<SplashState> emitter,
  ) async {
    if (event is SplashStatusChanged) {
      switch (event.status) {
        case SplashStatus.authenticated:
          emitter(const SplashState.authenticated());
          break;
        case SplashStatus.unauthenticated:
          emitter(const SplashState.unauthenticated());
          break;
        default:
          emitter(const SplashState.unauthenticated());
          break;
      }
    }
  }

  Future<void> _onCheckAuthentication(
    SplashEvent event,
    Emitter<SplashState> emitter,
  ) async {
    //TODO Handle check token
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    String accessToken = await SharedPreferencesManager.getAccessToken();
    if (accessToken.isNotEmpty) {
      // User is authenticated
      // You can also check if the token is valid by making an API call
      // If the token is valid, emit authenticated state
      emitter(
        state.copyWith(
          status: SplashStatus.authenticated,
        ),
      );
      return;
    }
    add(
      const SplashStatusChanged(
        SplashStatus.unauthenticated,
      ),
    );
  }
}
