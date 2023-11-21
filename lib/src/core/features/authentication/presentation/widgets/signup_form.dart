import 'package:ecommerce_user/routes/app_routes_constants.dart';
import 'package:ecommerce_user/src/core/features/authentication/presentation/widgets/custom_formfields.dart';
import 'package:ecommerce_user/utils/constants/validators.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../utils/constants/sizes.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
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

  final _formValidators = FormValidators();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
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
              textEditingController: _fullName,
              autofocus: false,
              obsecureText: false,
              validator: (value) => _formValidators.validateFullName(value),
            ),
            CustomFormField(
              icondata: const Icon(Icons.email),
              hintText: 'Email',
              textEditingController: _email,
              autofocus: false,
              obsecureText: false,
              validator: (value) => _formValidators.validateEmail(value),
            ),
            CustomFormField(
              icondata: const Icon(Icons.phone),
              hintText: 'Phone Number',
              textEditingController: _phoneNo,
              autofocus: false,
              obsecureText: false,
              validator: (value) => _formValidators.validatePhoneNumber(value),
            ),
            CustomFormField(
              icondata: const Icon(Icons.lock),
              hintText: 'Password',
              textEditingController: _password,
              autofocus: false,
              obsecureText: true,
              validator: (value) => _formValidators.validatePassword(value),
            ),
            CustomFormField(
              icondata: const Icon(Icons.lock),
              hintText: 'Confirm Password',
              textEditingController: _confirmPassword,
              autofocus: false,
              obsecureText: true,
              validator: (value) => _formValidators.validateConfirmPassword(
                  value, _password.text),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 10,
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace)),
              onPressed: () {
                ///validate form
                _validateForm();

                ///check if user has already registered record found in firebase
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text('SIGN UP'), Icon(Icons.arrow_forward)],
              ),
            ),
            Row(
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    ///go to login page
                    GoRouter.of(context).pushReplacementNamed(
                        MyAppRouteConstants.loginRouteName);
                  },
                  child: const Text('LogIn'),
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
      print(_fullName.text);
      print(_email.text);
      print(_phoneNo.text);
      print(_password.text);
      print(_confirmPassword.text);
      // Form is valid, proceed with your logic
      // _submitForm();
    }
  }
}
