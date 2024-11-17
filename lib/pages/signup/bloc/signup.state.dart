part of 'signup.bloc.dart';

class SignupState extends Equatable {
  final SignupStatus signupStatus;
  const SignupState(this.signupStatus);
  const SignupState.init() : signupStatus = SignupStatus.init;
  const SignupState.signUp() : signupStatus = SignupStatus.signUp;
  const SignupState.goToSignIn() : signupStatus = SignupStatus.goToSignIn;
  const SignupState.goToVerifySignUpCode()
      : signupStatus = SignupStatus.goToVerifySignUpCode;
  const SignupState.callApiSignUpFail()
      : signupStatus = SignupStatus.callApiSignUpFail;
  @override
  List<Object?> get props => [signupStatus];
}

class CallApiFailState extends SignupState {
  const CallApiFailState({required this.message})
      : super(SignupStatus.callApiSignUpFail);
  final String message;
}
