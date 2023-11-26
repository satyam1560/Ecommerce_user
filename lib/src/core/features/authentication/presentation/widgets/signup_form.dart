import 'package:ecommerce_user/routes/app_routes_constants.dart';
import 'package:ecommerce_user/src/core/features/authentication/presentation/bloc/signup/signup_cubit.dart';
import 'package:ecommerce_user/src/core/features/authentication/presentation/widgets/custom_formfields.dart';
import 'package:ecommerce_user/utils/constants/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../utils/constants/sizes.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required TextEditingController fullName,
    required TextEditingController email,
    required TextEditingController phoneNo,
    required TextEditingController password,
    required TextEditingController confirmPassword,
  })  : _fullName = fullName,
        _email = email,
        _phoneNo = phoneNo,
        _password = password,
        _confirmPassword = confirmPassword;

  final TextEditingController _fullName;
  final TextEditingController _email;
  final TextEditingController _phoneNo;
  final TextEditingController _password;
  final TextEditingController _confirmPassword;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formValidators = FormValidators();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.signupStatus == SignupStatus.error) {
              Fluttertoast.showToast(msg: '${state.error}');
            } else if (state.signupStatus == SignupStatus.success) {
              GoRouter.of(context)
                  .pushReplacementNamed(MyAppRouteConstants.loginRouteName);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 190),
                Text('Create Account',
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(
                  height: 30,
                ),
                CustomFormField(
                  icondata: const Icon(Icons.person),
                  hintText: 'Full Name',
                  textEditingController: widget._fullName,
                  autofocus: false,
                  obsecureText: false,
                  validator: (value) => _formValidators.validateFullName(value),
                ),
                CustomFormField(
                  icondata: const Icon(Icons.email),
                  hintText: 'Email',
                  textEditingController: widget._email,
                  autofocus: false,
                  obsecureText: false,
                  validator: (value) => _formValidators.validateEmail(value),
                ),
                CustomFormField(
                  icondata: const Icon(Icons.phone),
                  hintText: 'Phone Number',
                  textEditingController: widget._phoneNo,
                  autofocus: false,
                  obsecureText: false,
                  validator: (value) =>
                      _formValidators.validatePhoneNumber(value),
                ),
                CustomFormField(
                  icondata: const Icon(Icons.lock),
                  hintText: 'Password',
                  textEditingController: widget._password,
                  autofocus: false,
                  obsecureText: true,
                  validator: (value) => _formValidators.validatePassword(value),
                ),
                CustomFormField(
                  icondata: const Icon(Icons.lock),
                  hintText: 'Confirm Password',
                  textEditingController: widget._confirmPassword,
                  autofocus: false,
                  obsecureText: true,
                  validator: (value) => _formValidators.validateConfirmPassword(
                      value, widget._password.text),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                  ),
                  onPressed: state.signupStatus == SignupStatus.submitting
                      ? null
                      : _validateForm,
                  child: state.signupStatus == SignupStatus.submitting
                      ? const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: TSizes.defaultSpace),
                          child: CircularProgressIndicator(),
                        )
                      : const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('SIGN UP'),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                ),
                Row(
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).pushReplacementNamed(
                            MyAppRouteConstants.loginRouteName);
                      },
                      child: const Text('LogIn'),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      context.read<SignupCubit>().signup(
            fullName: widget._fullName.text,
            email: widget._email.text,
            phoneNumber: int.tryParse(widget._phoneNo.text)!,
            password: widget._password.text,
          );
    }
  }
}
