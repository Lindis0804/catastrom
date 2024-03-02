part of 'signup.bloc.dart';

class SignupState extends Equatable {
  final SignupStatus signupStatus;
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
