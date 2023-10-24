import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/sign_up/sign_up_connector.dart';
import 'package:flutter_authentication/features/styles/spacers.dart';
import 'package:flutter_authentication/features/widgets/app_scaffold.dart';
import 'package:flutter_authentication/features/widgets/input_field.dart';
import 'package:flutter_authentication/features/widgets/primary_button.dart';
import 'package:flutter_authentication/utilities/colors.dart';
import 'package:flutter_authentication/utilities/widget_constants.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    required this.onChangeId,
    required this.onChangePassword,
    required this.onLogin,
    required this.onDisposeCredentials,
    this.loginErrorMessage,
    this.identifier,
    this.password,
    super.key,
  });

  final String? loginErrorMessage;
  final String? identifier;
  final String? password;

  final ValueChanged<String> onChangeId;
  final ValueChanged<String> onChangePassword;
  final VoidCallback onLogin;
  final VoidCallback onDisposeCredentials;

  @override
  Widget build(BuildContext context) {
    const verticalSpace16 = VerticalSpace(defaultHalfSpacing);

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
            verticalSpace16,
            InputField(
              onChangeText: (identifier) => onChangeId(identifier),
              hintText: 'Username/Email',
            ),
            InputField(
              onChangeText: (password) => onChangePassword(password),
              obscureText: true,
              hintText: 'Password',
            ),
            if (loginErrorMessage != null) ...[
              Text(
                loginErrorMessage ?? '',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              verticalSpace16,
            ],
            PrimaryButton(
              onPressed: () {
                onLogin();
                FocusScope.of(context).requestFocus(FocusNode());
              },
              label: 'Login',
              color: mediumGrey,
            ),
            const VerticalSpace(defaultHalfSpacing),
            InkWell(
              onTap: () => context.pushNamed(SignUpConnector.routeName),
              child: const Text(
                'Sign up!',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
