import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/login_status.enum.dart';
import 'package:template/common/utils/size.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/common/widgets/error_dialog_utils.dart';
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

  void _handleSignIn() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    setState(() {
      wrongUsernameMessage = (username.isEmpty || !validateUserName(username))
          ? 'Tên đăng nhập chỉ được chứa chữ cái và chữ số'
          : '';
      wrongPasswordMessage = (password.isEmpty || !validatePassword(password))
          ? 'Mật khẩu phải chứa ít nhất 8 chữ cái - ít nhất 1 chữ thường, 1 chữ hoa, 1 chữ số và 1 kí tự đặc biệt'
          : '';
    });

    if (wrongUsernameMessage.isNotEmpty || wrongPasswordMessage.isNotEmpty) {
      return;
    }

    widget.loginBloc.add(Login(username: username, password: password));
  }

  @override
  Widget build(BuildContext context) {
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
                      margin: const EdgeInsets.only(bottom: 8),
                      child: const Text(
                        'Wellytics',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                            color: CustomColors.primary),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: CustomColors.textLabel),
                      ),
                    ),
                    FormTextField(
                      label: 'Tên đăng nhập',
                      errorMessage: wrongUsernameMessage,
                      controller: _usernameController,
                      onChanged: (username) {
                        setState(
                          () {
                            wrongUsernameMessage = (username.isNotEmpty &&
                                    !validateUserName(username))
                                ? 'Tên đăng nhập chỉ được chứa chữ cái và chữ số'
                                : '';
                          },
                        );
                      },
                    ),
                    FormTextField(
                      controller: _passwordController,
                      label: 'Mật khẩu',
                      errorMessage: wrongPasswordMessage,
                      isObscureText: _passwordObscureText,
                      onChanged: (password) {
                        setState(
                          () {
                            wrongPasswordMessage = (password.isNotEmpty &&
                                    !validatePassword(password))
                                ? 'Mật khẩu phải chứa ít nhất 8 chữ cái - ít nhất 1 chữ thường, 1 chữ hoa, 1 chữ số và 1 kí tự đặc biệt'
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
                        onPressed: state.loginStatus == LoginStatus.initialize
                            ? _handleSignIn
                            : null,
                        text: 'Đăng nhập',
                        backgroundColor: CustomColors.primary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.loginBloc.add(const MoveToSignUp());
                      },
                      child: const Text(
                        'Đăng kí',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: CustomColors.primary),
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
      Navigator.of(context).pushReplacementNamed(AppRouters.home);
      break;
    case LoginStatus.callApiLoginFail:
      if (state is CallApiLoginFailState) {
        ErrorDialogUtils.showErrorDialog(
          context: context,
          title: 'Đăng nhập không thành công',
          errorMessage: state.message,
        );
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
              title: const Text('Đăng nhập'),
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
