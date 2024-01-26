import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:e_learning/core/constants/enums/auth_enums.dart';
import 'package:e_learning/core/extensions/navigate_extension.dart';
import 'package:e_learning/core/utils/navigate_util.dart';
import 'package:e_learning/features/audiobook/ui/screens/audiobook.dart';
import 'package:e_learning/features/auth/bloc/auth_bloc.dart';
import 'package:e_learning/features/auth/ui/widgets/email_form_field.dart';
import 'package:e_learning/features/auth/ui/widgets/password_form_field.dart';
import 'package:e_learning/features/home/ui/screens/home.dart';
import 'package:e_learning/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.audioHandler });

  final AudioHandler audioHandler;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool? get validate => _formKey.currentState?.validate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state == const AuthState.onLoginSuccess()) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Home(audioHandler: widget.audioHandler,),
              ),
            );
          } else if (state == const AuthState.onLoginError()) {
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Stack(children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: Header(),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: EmailFormField(
                                emailController: _emailController,
                                emailTitle: "E-mail",
                                labelText: "Enter Work E-mail"),
                          ),
                          PasswordFormField(
                              passwordController: _passwordController,
                              passwordTitle: "Password",
                              labelText: "Enter Password"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                        child: Container(
                          height: 50,
                          child: SizedBox.expand(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red.shade800,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                if (validate != null && validate == true) {
                                  context.read<AuthBloc>().add(LoginRequested(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                      ));
                                }
                                // Navigator.of(context).pushAndRemoveUntil(
                                //     MaterialPageRoute(
                                //       builder: (context) => AudioDetails(),
                                //     ),
                                //     (route) => false);
                              },
                              child: Text(
                                "Log In",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Visibility(
                          visible: state == const AuthState.onLoginError()
                              ? true
                              : false,
                          child: const Text(
                            "invalid login",
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'OpenSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Text(
                            "   Or   ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'OpenSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Expanded(child: Divider())
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: Container(
                          height: 50,
                          child: SizedBox.expand(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => Audiobook(),
                                    ),
                                    (route) => false);
                              },
                              child: Text(
                                "Explore without Login",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible:
                    state == const AuthState.onLoginLoading() ? true : false,
                child: Container(
                  color: Colors.black38,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 100.0,
            horizontal: 50.0,
          ),
          child: Image.asset(Assets.assetImageLogo),
        ),
        Row(
          children: [
            Text(
              "Welcome Back!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Login to your account",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
