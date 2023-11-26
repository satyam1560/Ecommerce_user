import 'package:ecommerce_user/src/core/features/authentication/presentation/widgets/authentication_background.dart';
import 'package:flutter/material.dart';

import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const AuthenticationBackground(),
              LoginForm(
                  emailController: emailController,
                  passwordController: passwordController),
            ],
          ),
        ),
      ),
    );
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
  }
}
