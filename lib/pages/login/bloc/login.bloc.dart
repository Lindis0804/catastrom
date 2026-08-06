import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/auth/provider.dart';
import 'package:template/common/enums/login_status.enum.dart';
import 'package:equatable/equatable.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/auth/sign_in_response.model.dart';
part 'login.event.dart';
part 'login.state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState.initialize()) {
    on<ForgotPasswordWhenLogIn>(_onForgotPasswordWhenLogIn);
    on<LoginStatusChanged>(_onLoginStatusChanged);
    on<Inititalize>(_onInitialize);
    on<MoveToSignUp>(_onMoveToSignUp);
    on<Login>(_onLogin);
    on<MoveToHome>(_onMoveToHome);
    on<CallApiLoginFailEvent>(_onCallApiSignupFail);
  }
  void _onLoginStatusChanged(
    LoginEvent loginEvent,
    Emitter<LoginState> loginEmitter,
  ) {
    if (loginEvent is! LoginStatusChanged) {
      return;
    }
    switch (loginEvent.status) {
      case LoginStatus.forgotPassword:
        loginEmitter(const LoginState.forgotPassword());
        break;
      case LoginStatus.moveToSignUp:
        loginEmitter(const LoginState.moveToSignUp());
        break;
      case LoginStatus.login:
        loginEmitter(const LoginState.login());
        break;
      case LoginStatus.moveToHome:
        loginEmitter(const LoginState.moveToHome());
      default:
        loginEmitter(const LoginState.initialize());
        break;
    }
  }

  void _onInitialize(
      LoginEvent loginEvent, Emitter<LoginState> loginEmitter) async {
    String accessToken = await SharedPreferencesManager.getAccessToken();
    if (accessToken.isNotEmpty) {
      add(const MoveToHome());
      return;
    }
    add(const LoginStatusChanged(LoginStatus.initialize));
  }

  void _onForgotPasswordWhenLogIn(
      LoginEvent loginEvent, Emitter<LoginState> loginEmitter) {
    print('Forgot password.');
    add(const LoginStatusChanged(LoginStatus.forgotPassword));
  }

  void _onMoveToSignUp(
      LoginEvent loginEvent, Emitter<LoginState> loginEmitter) {
    add(const LoginStatusChanged(LoginStatus.moveToSignUp));
  }

  void _onLogin(LoginEvent loginEvent, Emitter<LoginState> loginEmitter) async {
    if (loginEvent is! Login) {
      return;
    }

    add(const LoginStatusChanged(LoginStatus.login));
    try {
      String username = loginEvent.username;
      String password = loginEvent.password;

      SignInResponse signInRes = await AuthApiProvider()
          .signIn(username: username, password: password);

      await SharedPreferencesManager.saveString(
          SPKeys.ACCESS_TOKEN, signInRes.accessToken);
      await SharedPreferencesManager.saveString(
          SPKeys.REFRESH_TOKEN, signInRes.refreshToken);
      await SharedPreferencesManager.saveString(
          SPKeys.USER_PROFILE, jsonEncode(signInRes.user.toJson()));

      add(
        const MoveToHome(),
      );
    } catch (err) {
      add(CallApiLoginFailEvent(message: '$err'));
    }
  }

  void _onMoveToHome(LoginEvent loginEvent, Emitter<LoginState> loginEmitter) {
    add(const LoginStatusChanged(LoginStatus.moveToHome));
  }

  void _onCallApiSignupFail(
      LoginEvent loginEvent, Emitter<LoginState> loginEmitter) {
    if (loginEvent is CallApiLoginFailEvent) {
      loginEmitter(CallApiLoginFailState(message: loginEvent.message));
    }
  }
}
