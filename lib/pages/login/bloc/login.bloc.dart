import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/login_status.enum.dart';
import 'package:equatable/equatable.dart';
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
  }
  void _onLoginStatusChanged(
    LoginEvent loginEvent,
    Emitter<LoginState> loginEmitter,
  ) {
    if (loginEvent is LoginStatusChanged) {
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
  }

  void _onInitialize(LoginEvent loginEvent, Emitter<LoginState> loginEmitter) {
    add(const LoginStatusChanged(LoginStatus.initialize));
  }

  void _onForgotPasswordWhenLogIn(
      LoginEvent loginEvent, Emitter<LoginState> loginEmitter) {
    print('Forgot password.');
    add(const LoginStatusChanged(LoginStatus.forgotPassword));
  }

  void _onMoveToSignUp(
      LoginEvent loginEvent, Emitter<LoginState> loginEmitter) {
    print('Create new account.');
    add(const LoginStatusChanged(LoginStatus.moveToSignUp));
  }

  void _onLogin(LoginEvent loginEvent, Emitter<LoginState> loginEmitter) {
    print('Gazer, log in!');
    if (loginEvent is Login) {
      String email = loginEvent.email;
      String password = loginEvent.password;
      print('$email $password');
    }

    add(const LoginStatusChanged(LoginStatus.moveToHome));
  }

  void _onMoveToHome(LoginEvent loginEvent, Emitter<LoginState> loginEmitter) {}
}
