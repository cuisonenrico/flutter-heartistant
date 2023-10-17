import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/styles/spacers.dart';
import 'package:flutter_authentication/features/widgets/app_scaffold.dart';
import 'package:flutter_authentication/features/widgets/input_field.dart';
import 'package:flutter_authentication/features/widgets/primary_button.dart';
import 'package:flutter_authentication/utilities/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const verticalSpace12 = SizedBox(height: 10);
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login Screen',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                color: mediumGrey,
              ),
            ),
            verticalSpace12,
            InputField(
              onChangeText: (text) {
                print('ITO PO ' + text.toString());
                // store in state
              },
              hintText: 'Username',
            ),
            verticalSpace12,
            InputField(
              onChangeText: (text) {
                // store in state
              },
              obscureText: true,
              hintText: 'Password',
            ),
            const VerticalSpace(24.0),
            PrimaryButton(
              onPressed: () {},
              label: 'Login',
              color: mediumGrey,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     PrimaryButton(
            //       onPressed: () {},
            //       label: 'Login',
            //       color: Colors.cyan,
            //     ),
            //     const HorizontalSpace(12),
            //     PrimaryButton(
            //       onPressed: () {},
            //       label: 'Sign Up',
            //       color: Colors.teal,
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
