part of 'login.bloc.dart';

class LoginState extends Equatable {
  final LoginStatus loginStatus;
  const LoginState.initialize() : loginStatus = LoginStatus.initialize;
  const LoginState.login() : loginStatus = LoginStatus.login;
  const LoginState.forgotPassword() : loginStatus = LoginStatus.forgotPassword;
  const LoginState.moveToSignUp() : loginStatus = LoginStatus.moveToSignUp;
  const LoginState.moveToHome() : loginStatus = LoginStatus.moveToHome;
  @override
  List<Object?> get props => [loginStatus];
}
