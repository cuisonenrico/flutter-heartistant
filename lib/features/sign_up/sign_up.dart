import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/styles/spacers.dart';
import 'package:flutter_authentication/features/widgets/app_bar.dart';
import 'package:flutter_authentication/features/widgets/app_scaffold.dart';
import 'package:flutter_authentication/features/widgets/input_field.dart';
import 'package:flutter_authentication/features/widgets/primary_button.dart';
import 'package:flutter_authentication/utilities/colors.dart';
import 'package:flutter_authentication/utilities/widget_constants.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              onChangeText: (_) {},
              hintText: 'Email',
            ),
            InputField(
              onChangeText: (_) {},
              hintText: 'Username',
            ),
            InputField(
              onChangeText: (_) {},
              hintText: 'Password',
            ),
            InputField(
              onChangeText: (_) {},
              hintText: 'Confirm Password ',
            ),
            PrimaryButton(
              onPressed: () {},
              label: 'Register',
              color: mediumGrey,
            ),
          ],
        ),
      ),
    );
  }
}
