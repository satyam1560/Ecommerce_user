import 'package:ecommerce_user/src/core/features/authentication/presentation/bloc/signin/signin_cubit.dart';
import 'package:ecommerce_user/src/core/features/authentication/presentation/widgets/custom_formfields.dart';
import 'package:ecommerce_user/utils/constants/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../routes/app_routes_constants.dart';
import '../../../../../../utils/constants/sizes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formValidator = FormValidators();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: BlocConsumer<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state.signinStatus == SigninStatus.error) {
              Fluttertoast.showToast(msg: '${state.error}');
            } else if (state.signinStatus == SigninStatus.success) {
              GoRouter.of(context)
                  .pushReplacementNamed(MyAppRouteConstants.homeRouteName);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 140),
                Center(
                    child: Text('Login',
                        style: Theme.of(context).textTheme.headlineLarge)),
                const SizedBox(height: 140),
                const Text('Please sign in to continue'),
                const SizedBox(height: TSizes.defaultSpace),
                CustomFormField(
                  hintText: 'Email Id',
                  icondata: const Icon(Icons.email),
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: widget.emailController,
                  autofocus: true,
                  obsecureText: false,
                  validator: (value) => _formValidator.validateEmail(value),
                ),
                const SizedBox(height: TSizes.defaultSpace),
                CustomFormField(
                  hintText: 'Enter Password',
                  icondata: const Icon(Icons.lock),
                  textEditingController: widget.passwordController,
                  autofocus: true,
                  obsecureText: true,
                  validator: (value) => _formValidator.validatePassword(value),
                ),
                const SizedBox(
                  height: TSizes.buttonHeight,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                  ),
                  onPressed: state.signinStatus == SigninStatus.submitting
                      ? null
                      : _validateForm,
                  child: state.signinStatus == SigninStatus.submitting
                      ? const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: TSizes.defaultSpace),
                          child: CircularProgressIndicator(),
                        )
                      : const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [Text('LOGIN'), Icon(Icons.arrow_forward)],
                        ),
                ),
                const SizedBox(
                  height: TSizes.buttonHeight,
                ),
                Row(
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        ///go to sign up page
                        GoRouter.of(context).pushReplacementNamed(
                            MyAppRouteConstants.signupRouteName);
                      },
                      child: const Text('Sign up'),
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
    // Validate the form
    if (_formKey.currentState?.validate() ?? false) {
      context.read<SigninCubit>().signin(
            email: widget.emailController.text,
            password: widget.passwordController.text,
          );

      // BlocProvider.of<AuthenticationBloc>(context)
      //     .add(AuthUserChanged(user: userDetails));
      // Form is valid, proceed with your logic
      // _submitForm();
    }
  }
}
