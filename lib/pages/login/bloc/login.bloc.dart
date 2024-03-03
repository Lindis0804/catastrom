import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/constants/host.dart';
import 'package:template/common/constants/keys.dart';
import 'package:template/common/enums/login_status.enum.dart';
import 'package:equatable/equatable.dart';
import 'package:template/common/ultis/share_preferences.dart';
import 'package:template/pages/login/dto/LoginUser.dto.dart';
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

  void _onLogin(LoginEvent loginEvent, Emitter<LoginState> loginEmitter) async {
    print('Gazer, log in!');
    if (loginEvent is! Login) {
      return;
    }
    add(const LoginStatusChanged(LoginStatus.login));
    try {
      String username = loginEvent.username;
      String password = loginEvent.password;
      bool rememberMe = loginEvent.rememberMe;
      LoginUser loginUserData = LoginUser(
          username: username, password: password, rememberMe: rememberMe);

      Dio dio = Dio(BaseOptions(connectTimeout: 10000));
      Response res =
          await dio.post('${Host.address}/api/login', data: loginUserData);
      if (res.statusCode == 200) {
        String accessToken = res.data['data']['accessToken'] ?? '';
        if (accessToken == '') {
          add(const CallApiLoginFailEvent(message: 'Access token is empty'));
          return;
        }
        await SharedPreferencesManager.saveString(
            ACCESS_TOKEN_KEY, accessToken);
        add(const MoveToHome());
      } else {
        add(const CallApiLoginFailEvent(
            message: 'Username or password is incorrect.'));
      }
    } catch (err) {
      print('Error in call api log in');
      add(CallApiLoginFailEvent(message: 'Call api login fail: $err'));
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
