import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/signup_status.enum.dart';
import 'package:template/common/utils/size.dart';
import 'package:template/common/utils/validate.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/generated/assets.gen.dart';
import 'package:template/pages/signup/bloc/signup.bloc.dart';
import 'package:template/pages/signup/loading.screen.dart';
import 'package:template/root/app_routers.dart';

class SignupForm extends StatefulWidget {
  final SignupBloc signupBloc;
  const SignupForm({super.key, required this.signupBloc});
  @override
  _SignupForm createState() => _SignupForm();
}

class _SignupForm extends State<SignupForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String wrongUsernameMessage = '',
      wrongFirstNameMessage = '',
      wrongLastNameMessage = '',
      wrongPhoneNumberMessage = '',
      wrongPasswordMessage = '',
      wrongConfirmPasswordMessage = '';
  bool _passwordObscureText = true, _confirmPasswordObscureText = true;

  bool enableSignUp(SignupBloc signupBloc) {
    if (wrongUsernameMessage.isNotEmpty ||
        wrongFirstNameMessage.isNotEmpty ||
        wrongLastNameMessage.isNotEmpty ||
        wrongPhoneNumberMessage.isNotEmpty ||
        wrongPasswordMessage.isNotEmpty ||
        wrongConfirmPasswordMessage.isNotEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        signupBloc.state.signupStatus != SignupStatus.init) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return Stack(
          children: [
            Visibility(
              visible: state.signupStatus == SignupStatus.signUp,
              child: const Loading(),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              width: screenWidth,
              height: screenHeight,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Image(
                          image: Assets.images.logo4x.provider(),
                          width: 150,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: const Text(
                          'Welcome to DoLa Trip',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Colors.green),
                        ),
                      ),
                      FormTextField(
                        label: 'First Name',
                        errorMessage: wrongFirstNameMessage,
                        controller: _firstNameController,
                        onChanged: (text) => {
                          setState(
                            () {
                              wrongFirstNameMessage = (text.isNotEmpty &&
                                      !validateName(text))
                                  ? 'First Name can only contains alphabetic characters.'
                                  : '';
                            },
                          ),
                        },
                      ),
                      FormTextField(
                        label: 'Last Name',
                        errorMessage: wrongLastNameMessage,
                        controller: _lastNameController,
                        onChanged: (text) => {
                          setState(
                            () {
                              wrongLastNameMessage = (text.isNotEmpty &&
                                      !validateName(text))
                                  ? 'Last Name can only contains alphabetic characters.'
                                  : '';
                            },
                          ),
                        }, placeholder: '',
                      ),
                      FormTextField(
                        label: 'Phone Number',
                        errorMessage: wrongPhoneNumberMessage,
                        controller: _phoneNumberController,
                        onChanged: (phoneNumber) => {
                          setState(() {
                            wrongPhoneNumberMessage = (phoneNumber.isNotEmpty &&
                                    !validatePhoneNumber(phoneNumber))
                                ? 'Phone number must have at least 9 digits'
                                : '';
                          })
                        },
                      ),
                      FormTextField(
                        label: 'Username',
                        errorMessage: wrongUsernameMessage,
                        controller: _usernameController,
                        onChanged: (username) {
                          setState(
                            () {
                              wrongUsernameMessage = (username.isNotEmpty &&
                                      !validateUserName(username))
                                  ? 'Username must have at least 8 character, contain at least 1 letter and 1 digit.'
                                  : '';
                            },
                          );
                        },
                      ),
                      FormTextField(
                        controller: _passwordController,
                        label: 'Password',
                        errorMessage: wrongPasswordMessage,
                        suffixIcon: IconButton(
                          icon: _passwordObscureText
                              ? SvgPicture.asset(
                                  'assets/icons/ic_eye_off.svg',
                                  width: 20,
                                  height: 20,
                                )
                              : const Icon(Icons.remove_red_eye, size: 20),
                          onPressed: () {
                            setState(
                              () {
                                _passwordObscureText = !_passwordObscureText;
                              },
                            );
                          },
                        ),
                        isObscureText: _passwordObscureText,
                        onChanged: (password) {
                          setState(
                            () {
                              wrongPasswordMessage = (password.isNotEmpty &&
                                      !validatePassword(password))
                                  ? 'Password must have at least 5 characters - include at least 1 lower case letter, 1 uppder case letter, 1 digit and 1 special letter'
                                  : '';
                            },
                          );
                        },
                      ),
                      FormTextField(
                        controller: _confirmPasswordController,
                        isObscureText: _confirmPasswordObscureText,
                        label: 'Confirm Password',
                        errorMessage: wrongConfirmPasswordMessage,
                        suffixIcon: IconButton(
                          icon: _confirmPasswordObscureText
                              ? SvgPicture.asset(
                                  'assets/icons/ic_eye_off.svg',
                                  width: 20,
                                  height: 20,
                                )
                              : const Icon(Icons.remove_red_eye, size: 20),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordObscureText =
                                  !_confirmPasswordObscureText;
                            });
                          },
                        ),
                        onChanged: (confirmPassword) {
                          setState(
                            () {
                              wrongConfirmPasswordMessage = (confirmPassword !=
                                      _passwordController.text)
                                  ? 'ConfirmePassword is not the same to password.'
                                  : '';
                            },
                          );
                        },
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: BigCustomButton(
                            onPressed: (enableSignUp(widget.signupBloc))
                                ? () {
                                    widget.signupBloc.add(SignUp(
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        phoneNumber:
                                            _phoneNumberController.text,
                                        username: _usernameController.text,
                                        password: _passwordController.text));
                                  }
                                : null,
                            text: 'Sign Up',
                            backgroundColor: enableSignUp(widget.signupBloc)
                                ? CustomColors.primary
                                : CustomColors.gray),
                      ),
                      InkWell(
                        onTap: () {
                          widget.signupBloc.add(const GoToSignIn());
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: Colors.green[700]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //  ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider<SignupBloc>(
        create: (_) => SignupBloc(),
        child: BlocListener<SignupBloc, SignupState>(
          listenWhen: (previous, current) =>
              previous.signupStatus != current.signupStatus,
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: SignupForm(signupBloc: context.read<SignupBloc>()),
              ),
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, SignupState state) {
  switch (state.signupStatus) {
    case SignupStatus.goToSignIn:
      Navigator.of(context).pushReplacementNamed(AppRouters.login);
      context.read<SignupBloc>().add(const Inititalize());
      break;
    case SignupStatus.goToHome:
      Navigator.of(context).pushReplacementNamed(AppRouters.home);
      break;
    case SignupStatus.goToVerifySignUpCode:
      Navigator.of(context).pushReplacementNamed(AppRouters.home);
      break;
    case SignupStatus.callApiSignUpFail:
      if (state is CallApiFailState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            duration: const Duration(seconds: 2),
          ),
        );
        context.read<SignupBloc>().add(const Inititalize());
      }
      break;
    default:
  }
}
