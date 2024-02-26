part of 'signup.bloc.dart';

sealed class SignupEvent {
  const SignupEvent();
}

class Inititalize extends SignupEvent {
  const Inititalize();
}

class GoToSignIn extends SignupEvent {
  const GoToSignIn();
}

class SignupStatusChanged extends SignupEvent {
  final SignupStatus status;
  const SignupStatusChanged(this.status);
}
