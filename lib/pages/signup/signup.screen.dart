import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/common/enums/signup_status.enum.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/generated/assets.gen.dart';
import 'package:template/pages/signup/bloc/signup.bloc.dart';
import 'package:template/root/app_routers.dart';

class SignupForm extends StatefulWidget {
  final SignupBloc signupBloc;
  const SignupForm({required this.signupBloc});
  @override
  _SignupForm createState() => _SignupForm();
}

class _SignupForm extends State<SignupForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordObscureText = true, _confirmPasswordObscureText = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Image(
                image: Assets.images.logoImage4x.provider(),
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
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const NormalTextfield(
                text: 'First Name',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const NormalTextfield(
                text: 'Last Name',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const NormalTextfield(
                text: 'Phone',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const NormalTextfield(
                text: 'Username',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: NormalTextfield(
                controller: _passwordController,
                text: 'Password',
                suffixIcon: IconButton(
                  icon: _passwordObscureText
                      ? SvgPicture.asset(
                          'assets/icons/ic_eye_off.svg',
                          width: 20,
                          height: 20,
                        )
                      : const Icon(Icons.remove_red_eye, size: 20),
                  onPressed: () {
                    setState(() {
                      _passwordObscureText = !_passwordObscureText;
                    });
                  },
                ),
                isObscureText: _passwordObscureText,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: NormalTextfield(
                  controller: _confirmPasswordController,
                  isObscureText: _confirmPasswordObscureText,
                  text: 'Confirm Password',
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
                )),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              child: BigCustomButton(onPressed: () {}, text: 'Sign Up'),
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
                ))
          ],
        ),
      ),
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
      Navigator.of(context).pushNamed(AppRouters.login);
      context.read<SignupBloc>().add(const Inititalize());
      break;
    default:
  }
}
