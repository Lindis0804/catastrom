import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/signup_status.enum.dart';
import 'package:template/common/utils/size.dart';
import 'package:template/common/utils/validate.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/common/widgets/error_dialog_utils.dart';
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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String wrongUsernameMessage = '',
      wrongFirstNameMessage = '',
      wrongLastNameMessage = '',
      wrongPasswordMessage = '',
      wrongConfirmPasswordMessage = '';
  bool _passwordObscureText = true, _confirmPasswordObscureText = true;

  static const String _usernameErrorMessage =
      'Tên đăng nhập chỉ được chứa chữ cái và chữ số';
  static const String _passwordErrorMessage =
      'Mật khẩu phải chứa ít nhất 8 chữ cái - ít nhất 1 chữ thường, 1 chữ hoa, 1 chữ số và 1 kí tự đặc biệt';
  static const String _firstNameErrorMessage =
      'Họ và tên đệm chỉ được chứa chữ cái';
  static const String _lastNameErrorMessage = 'Tên chỉ được chứa chữ cái';
  static const String _confirmPasswordErrorMessage =
      'Mật khẩu xác nhận không khớp';

  void _handleSignUp() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    setState(() {
      wrongFirstNameMessage =
          (firstName.isEmpty || !validateName(firstName))
              ? _firstNameErrorMessage
              : '';
      wrongLastNameMessage = (lastName.isEmpty || !validateName(lastName))
          ? _lastNameErrorMessage
          : '';
      wrongUsernameMessage =
          (username.isEmpty || !validateUserName(username))
              ? _usernameErrorMessage
              : '';
      wrongPasswordMessage =
          (password.isEmpty || !validatePassword(password))
              ? _passwordErrorMessage
              : '';
      wrongConfirmPasswordMessage = (confirmPassword != password)
          ? _confirmPasswordErrorMessage
          : '';
    });

    if (wrongFirstNameMessage.isNotEmpty ||
        wrongLastNameMessage.isNotEmpty ||
        wrongUsernameMessage.isNotEmpty ||
        wrongPasswordMessage.isNotEmpty ||
        wrongConfirmPasswordMessage.isNotEmpty) {
      return;
    }

    widget.signupBloc.add(SignUp(
      firstName: firstName,
      lastName: lastName,
      username: username,
      password: password,
    ));
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
                        margin: const EdgeInsets.only(bottom: 8),
                        child: const Text(
                          'Wellytics',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: CustomColors.primary),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: const Text(
                          'Đăng kí',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: CustomColors.textLabel),
                        ),
                      ),
                      FormTextField(
                        label: 'Họ và tên đệm',
                        errorMessage: wrongFirstNameMessage,
                        controller: _firstNameController,
                        onChanged: (text) => {
                          setState(
                            () {
                              wrongFirstNameMessage = (text.isNotEmpty &&
                                      !validateName(text))
                                  ? _firstNameErrorMessage
                                  : '';
                            },
                          ),
                        },
                      ),
                      FormTextField(
                        label: 'Tên',
                        errorMessage: wrongLastNameMessage,
                        controller: _lastNameController,
                        onChanged: (text) => {
                          setState(
                            () {
                              wrongLastNameMessage = (text.isNotEmpty &&
                                      !validateName(text))
                                  ? _lastNameErrorMessage
                                  : '';
                            },
                          ),
                        },
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
                                  ? _usernameErrorMessage
                                  : '';
                            },
                          );
                        },
                      ),
                      FormTextField(
                        controller: _passwordController,
                        label: 'Mật khẩu',
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
                                  ? _passwordErrorMessage
                                  : '';
                            },
                          );
                        },
                      ),
                      FormTextField(
                        controller: _confirmPasswordController,
                        isObscureText: _confirmPasswordObscureText,
                        label: 'Nhập lại mật khẩu',
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
                                  ? _confirmPasswordErrorMessage
                                  : '';
                            },
                          );
                        },
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: BigCustomButton(
                            onPressed:
                                state.signupStatus == SignupStatus.init
                                    ? _handleSignUp
                                    : null,
                            text: 'Đăng kí',
                            backgroundColor: CustomColors.primary),
                      ),
                      InkWell(
                        onTap: () {
                          widget.signupBloc.add(const GoToSignIn());
                        },
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: CustomColors.primary),
                        ),
                      )
                    ],
                  ),
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
        ErrorDialogUtils.showErrorDialog(
          context: context,
          title: 'Đăng kí không thành công',
          errorMessage: state.message,
        );
        context.read<SignupBloc>().add(const Inititalize());
      }
      break;
    default:
  }
}
