import 'package:ecommerce_user/src/core/features/authentication/presentation/widgets/custom_formfields.dart';
import 'package:ecommerce_user/utils/constants/validators.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../routes/app_routes_constants.dart';
import '../../../../../../utils/constants/sizes.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    super.key,
    required this.phoneController,
    required this.passwordController,
  });

  final TextEditingController phoneController;
  final TextEditingController passwordController;

  final _formValidator = FormValidators();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
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
              hintText: 'Phone No.',
              icondata: const Icon(Icons.phone),
              keyboardType: TextInputType.phone,
              textEditingController: phoneController,
              autofocus: true,
              obsecureText: false,
              validator: (value) => _formValidator.validatePhoneNumber(value),
            ),
            const SizedBox(height: TSizes.defaultSpace),
            CustomFormField(
              hintText: 'Enter Password',
              icondata: const Icon(Icons.lock),
              textEditingController: passwordController,
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
                      horizontal: TSizes.defaultSpace)),
              onPressed: () {
                ///validate form
                _validateForm();

                ///signin with phoneno and password

                ///check if user is not registered
                ///go to signup page
                ///else home page
              },
              child: const Row(
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
        ),
      ),
    );
  }

  void _validateForm() {
    // Validate the form
    if (_formKey.currentState?.validate() ?? false) {
      print(phoneController.text);
      print(passwordController.text);

      // Form is valid, proceed with your logic
      // _submitForm();
    }
  }
}
