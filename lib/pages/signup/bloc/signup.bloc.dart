import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/signup_status.enum.dart';
import 'package:equatable/equatable.dart';
part 'signup.event.dart';
part 'signup.state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState.init()) {
    on<SignupStatusChanged>(_onSignupStatusChanged);
    on<Inititalize>(_onInitialize);
    on<GoToSignIn>(_onGoToSignIn);
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
}
