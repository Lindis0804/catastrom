part of 'signup.bloc.dart';

sealed class SignupEvent {
  const SignupEvent();
}

class Inititalize extends SignupEvent {
  const Inititalize();
}

class SignUp extends SignupEvent {
  const SignUp(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.username,
      required this.password});
  final String firstName, lastName, phoneNumber, username, password;
}

class GoToSignIn extends SignupEvent {
  const GoToSignIn();
}

class SignupStatusChanged extends SignupEvent {
  final SignupStatus status;
  const SignupStatusChanged(this.status);
}

class GoToVerifySignUpCode extends SignupEvent {
  const GoToVerifySignUpCode();
}

class CallApiSignupFail extends SignupEvent {
  const CallApiSignupFail({required this.message});
  final String message;
}
