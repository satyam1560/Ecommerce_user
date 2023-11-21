import 'package:ecommerce_user/src/core/features/authentication/presentation/widgets/authentication_background.dart';
import 'package:flutter/material.dart';

import '../widgets/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const AuthenticationBackground(),
              SignUpForm(
                  fullName: _fullName,
                  email: _email,
                  phoneNo: _phoneNo,
                  password: _password,
                  confirmPassword: _confirmPassword),
            ],
          ),
        ),
      ),
    );
  }
}
