import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/auth/provider.dart';
import 'package:template/common/enums/signup_status.enum.dart';
import 'package:equatable/equatable.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/auth/sign_in_response.model.dart';
part 'signup.event.dart';
part 'signup.state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState.init()) {
    on<SignupStatusChanged>(_onSignupStatusChanged);
    on<Inititalize>(_onInitialize);
    on<GoToSignIn>(_onGoToSignIn);
    on<SignUp>(_onSignUp);
    on<CallApiSignupFail>(_onCallApiSignupFail);
    on<GoToVerifySignUpCode>(_onGoToVerifySignUpCode);
  }
  void _onSignupStatusChanged(
    SignupEvent signupEvent,
    Emitter<SignupState> signupEmitter,
  ) {
    if (signupEvent is SignupStatusChanged) {
      switch (signupEvent.status) {
        case SignupStatus.goToSignIn:
          signupEmitter(const SignupState.goToSignIn());
          break;
        case SignupStatus.signUp:
          signupEmitter(const SignupState.signUp());
          break;
        case SignupStatus.callApiSignUpFail:
          signupEmitter(const SignupState.callApiSignUpFail());
          break;
        case SignupStatus.goToVerifySignUpCode:
          signupEmitter(const SignupState.goToVerifySignUpCode());
          break;
        case SignupStatus.goToHome:
          signupEmitter(const SignupState.goToHome());
          break;
        default:
          signupEmitter(const SignupState.init());
          break;
      }
    }
  }

  void _onInitialize(
      SignupEvent signupEvent, Emitter<SignupState> signupEmitter) {
    add(const SignupStatusChanged(SignupStatus.init));
  }

  void _onGoToSignIn(
      SignupEvent signupEvent, Emitter<SignupState> signupEmitter) {
    add(const SignupStatusChanged(SignupStatus.goToSignIn));
  }

  void _onSignUp(
      SignupEvent signupEvent, Emitter<SignupState> signupEmitter) async {
    if (signupEvent is! SignUp) {
      return;
    }
    add(const SignupStatusChanged(SignupStatus.signUp));
    try {
      SignInResponse signInRes = await AuthApiProvider().signUp(
        username: signupEvent.username,
        password: signupEvent.password,
        firstName: signupEvent.firstName,
        lastName: signupEvent.lastName,
      );

      await SharedPreferencesManager.saveString(
          SPKeys.ACCESS_TOKEN, signInRes.accessToken);
      await SharedPreferencesManager.saveString(
          SPKeys.REFRESH_TOKEN, signInRes.refreshToken);
      await SharedPreferencesManager.saveString(
          SPKeys.USER_PROFILE, jsonEncode(signInRes.user.toJson()));

      add(const SignupStatusChanged(SignupStatus.goToHome));
    } catch (err) {
      add(CallApiSignupFail(message: '$err'));
    }
  }

  void _onCallApiSignupFail(
      SignupEvent signupEvent, Emitter<SignupState> signupEmitter) {
    if (signupEvent is CallApiSignupFail) {
      signupEmitter(CallApiFailState(message: signupEvent.message));
    }
  }

  void _onGoToVerifySignUpCode(
      SignupEvent signupEvent, Emitter<SignupState> signupEmitter) {
    add(const SignupStatusChanged(SignupStatus.goToVerifySignUpCode));
  }
}
