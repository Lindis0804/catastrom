import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/login_status.enum.dart';
import 'package:template/common/utils/size.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/generated/assets.gen.dart';
import 'package:template/pages/login/bloc/login.bloc.dart';
import 'package:template/pages/signup/loading.screen.dart';
import 'package:template/root/app_routers.dart';
import 'package:template/common/utils/validate.dart';

class SignInForm extends StatefulWidget {
  final LoginBloc loginBloc;
  const SignInForm({super.key, required this.loginBloc});
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String wrongUsernameMessage = '', wrongPasswordMessage = '';
  bool _passwordObscureText = true;

  bool enableLogin() {
    // if (_usernameController.text.isEmpty ||
    //     _passwordController.text.isEmpty ||
    //     wrongUsernameMessage.isNotEmpty ||
    //     wrongPasswordMessage.isNotEmpty) {
    //   return false;
    // }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //print({'status__': widget.loginBloc.state.loginStatus});
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Stack(
          children: [
            Visibility(
              visible: state.loginStatus == LoginStatus.login,
              child: const Loading(),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              width: screenWidth,
              height: screenHeight,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Image(
                        image: Assets.images.logo4x.provider(),
                        width: 170,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Text(
                        'Welcome to DoLa Trip',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                            color: CustomColors.primary),
                      ),
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
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Forgot Password')));
                          widget.loginBloc.add(const ForgotPasswordWhenLogIn());
                        },
                        child: Text(
                          'Forgot password ? 🧐',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                              fontSize: 15),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: BigCustomButton(
                        onPressed: (enableLogin() &&
                                state.loginStatus == LoginStatus.initialize)
                            ? () {
                                widget.loginBloc.add(
                                  Login(
                                      username: _usernameController.text,
                                      password: _passwordController.text),
                                );
                              }
                            : null,
                        text: 'Sign In',
                        backgroundColor: enableLogin()
                            ? CustomColors.primary
                            : CustomColors.disable,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.loginBloc.add(const MoveToSignUp());
                      },
                      child: Text(
                        'Create new account',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: Colors.green[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
  }
}

void _listener(BuildContext context, LoginState state) {
  switch (state.loginStatus) {
    case LoginStatus.forgotPassword:
      Navigator.of(context).pushNamed(AppRouters.forgotPassword);
      context.read<LoginBloc>().add(const Inititalize());
      break;
    case LoginStatus.moveToSignUp:
      Navigator.of(context).pushReplacementNamed(AppRouters.signUp);
      break;
    case LoginStatus.moveToHome:
      print('Move to home');
      Navigator.of(context).pushReplacementNamed(AppRouters.home);
      break;
    case LoginStatus.callApiLoginFail:
      if (state is CallApiLoginFailState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
          duration: const Duration(seconds: 2),
        ));
      }
      context.read<LoginBloc>().add(const Inititalize());
      break;
    case LoginStatus.login:
    default:
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: ((previous, current) =>
            previous.loginStatus != current.loginStatus),
        listener: _listener,
        child: Builder(
          builder: (BuildContext context) => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text(
                'Login Screen',
              ),
            ),
            body: SingleChildScrollView(
              child: SignInForm(loginBloc: context.read<LoginBloc>()),
            ),
          ),
        ),
      ),
    );
  }
}
