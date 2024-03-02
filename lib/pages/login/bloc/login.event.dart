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
  final String email;
  final String password;
  const Login({required this.email, required this.password});
}

class MoveToHome extends LoginEvent {
  const MoveToHome();
}

class LoginStatusChanged extends LoginEvent {
  final LoginStatus status;
  const LoginStatusChanged(this.status);
}
