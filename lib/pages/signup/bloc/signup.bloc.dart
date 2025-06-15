import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/constants/keys.dart';
import 'package:template/common/enums/signup_status.enum.dart';
import 'package:equatable/equatable.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/pages/signup/dto/signup.dto.dart';
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
      String firstName = signupEvent.firstName;
      String lastName = signupEvent.lastName;
      String username = signupEvent.username;
      String password = signupEvent.password;
      String phoneNumber = signupEvent.phoneNumber;
      Dio dio = Dio(
        BaseOptions(connectTimeout: 10000),
      );
      SignUpUserDto signUpUserData = SignUpUserDto(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          username: username,
          password: password);
      Response res = await dio.post(
        '${EnvVariable.clientCustomerHost}/api/signup',
        data: signUpUserData.toJson(),
      );
      if (res.statusCode == 200) {
        String accessToken = res.data['data']['accessToken'] ?? '';
        if (accessToken == '') {
          add(const CallApiSignupFail(message: 'Access token is empty'));
          return;
        }
        await SharedPreferencesManager.saveString(
            ACCESS_TOKEN_KEY, accessToken);
        add(const GoToVerifySignUpCode());
      }
    } catch (err) {
      add(const CallApiSignupFail(message: 'Call api sign up fail'));
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
