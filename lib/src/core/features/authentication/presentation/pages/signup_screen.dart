// import 'package:ecommerce_user/src/core/features/authentication/presentation/bloc/signup/signup_cubit.dart';
import 'package:ecommerce_user/src/core/features/authentication/presentation/widgets/authentication_background.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../../../routes/app_routes_constants.dart';
// import '../bloc/auth/authentication_bloc.dart';
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

  void clearForm() {
    _fullName.clear();
    _email.clear();
    _phoneNo.clear();
    _password.clear();
    _confirmPassword.clear();
  }
}
