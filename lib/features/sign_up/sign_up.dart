import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/styles/spacers.dart';
import 'package:flutter_authentication/features/widgets/app_bar.dart';
import 'package:flutter_authentication/features/widgets/app_scaffold.dart';
import 'package:flutter_authentication/features/widgets/input_field.dart';
import 'package:flutter_authentication/features/widgets/primary_button.dart';
import 'package:flutter_authentication/utilities/colors.dart';
import 'package:flutter_authentication/utilities/widget_constants.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    required this.onChangeEmail,
    required this.onChangeUsername,
    required this.onChangePassword,
    required this.onChangeConfirmPassword,
    required this.onDisposeSignupForm,
    required this.onSignUpWithEmailAndPassword,
    super.key,
  });

  final ValueChanged<String?> onChangeEmail;
  final ValueChanged<String?> onChangeUsername;
  final ValueChanged<String?> onChangePassword;
  final ValueChanged<String?> onChangeConfirmPassword;
  final VoidCallback onDisposeSignupForm;
  final VoidCallback onSignUpWithEmailAndPassword;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MyAppBar(
        onSecondaryActionPressed: () {},
        label: '',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                color: mediumGrey,
              ),
            ),
            const VerticalSpace(defaultHalfSpacing),
            InputField(
              onChangeText: (email) => onChangeEmail(email),
              hintText: 'Email',
            ),
            // InputField(
            //   onChangeText: (username) => onChangeUsername(username),
            //   hintText: 'Username',
            // ),
            InputField(
              obscureText: true,
              onChangeText: (password) => onChangePassword(password),
              hintText: 'Password',
            ),
            InputField(
              obscureText: true,
              onChangeText: (confirmPassword) => onChangeConfirmPassword(confirmPassword),
              hintText: 'Confirm Password ',
            ),
            PrimaryButton(
              onPressed: onSignUpWithEmailAndPassword,
              label: 'Register',
              color: mediumGrey,
            ),
          ],
        ),
      ),
    );
  }
}
