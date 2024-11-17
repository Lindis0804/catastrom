part of 'login.bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

class ForgotPasswordWhenLogIn extends LoginEvent {
  const ForgotPasswordWhenLogIn();
}

class MoveToSignUp extends LoginEvent {
  const MoveToSignUp();
}

class Inititalize extends LoginEvent {
  const Inititalize();
}

class Login extends LoginEvent {
  final String username;
  final String password;
  final bool rememberMe;
  const Login(
      {required this.username, required this.password, this.rememberMe = true});
}

class MoveToHome extends LoginEvent {
  const MoveToHome();
}

class LoginStatusChanged extends LoginEvent {
  final LoginStatus status;
  const LoginStatusChanged(this.status);
}

class CallApiLoginFailEvent extends LoginEvent {
  final String message;
  const CallApiLoginFailEvent({required this.message});
}
