import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/common/enums/login_status.enum.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/generated/assets.gen.dart';
import 'package:template/pages/login/bloc/login.bloc.dart';
import 'package:template/root/app_routers.dart';
import 'package:logger/logger.dart';

class SignInForm extends StatefulWidget {
  final LoginBloc loginBloc;
  const SignInForm({required this.loginBloc});
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    print('Sign in');
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Image(
              image: Assets.images.logoImage4x.provider(),
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
                  color: Colors.green),
            ),
          ),
          NormalTextfield(
            text: 'Email',
            controller: _emailController,
          ),
          Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              child: NormalTextfield(
                controller: _passwordController,
                isObscureText: _obscureText,
                text: 'Password',
                suffixIcon: IconButton(
                  icon: _obscureText
                      ? SvgPicture.asset(
                          'assets/icons/ic_eye_off.svg',
                          width: 20,
                          height: 20,
                        )
                      : const Icon(Icons.remove_red_eye, size: 20),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              )),
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
                onPressed: () {
                  widget.loginBloc.add(Login(
                      email: _emailController.text,
                      password: _passwordController.text));
                },
                text: 'Sign In'),
          ),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Create new account.')));
              widget.loginBloc.add(const MoveToSignUp());
            },
            child: Text(
              'Create new account',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Colors.green[700]),
            ),
          )
        ],
      ),
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
    default:
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
