import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/sign_up/sign_up_connector.dart';
import 'package:flutter_authentication/features/styles/spacers.dart';
import 'package:flutter_authentication/features/styles/styles.dart';
import 'package:flutter_authentication/features/widgets/app_scaffold.dart';
import 'package:flutter_authentication/features/widgets/input_field.dart';
import 'package:flutter_authentication/features/widgets/primary_button.dart';
import 'package:flutter_authentication/gen/assets.gen.dart';
import 'package:flutter_authentication/utilities/colors.dart';
import 'package:flutter_authentication/utilities/widget_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    required this.onChangeId,
    required this.onChangePassword,
    required this.onLogin,
    required this.onLoginWithGoogle,
    required this.onLoginWithFacebook,
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
  final VoidCallback onLoginWithGoogle;
  final VoidCallback onLoginWithFacebook;

  @override
  Widget build(BuildContext context) {
    const verticalSpace16 = VerticalSpace(defaultHalfSpacing);
    const verticalSpace8 = VerticalSpace(defaultQuarterSpacing);

    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.pngImages.heartistantLogo.image(height: 150, width: 150),
            verticalSpace16,
            InputField(
              onChangeText: (identifier) => onChangeId(identifier),
              hintText: 'Username/Email',
              icon: Icons.mail,
            ),
            InputField(
              onChangeText: (password) => onChangePassword(password),
              obscureText: true,
              hintText: 'Password',
              icon: Icons.lock,
            ),
            PrimaryButton(
              onPressed: onLogin,
              label: 'Sign in!',
              color: Colors.blueAccent,
              width: 220,
            ),
            verticalSpace8,
            PrimaryButton(
              onPressed: onLoginWithFacebook,
              label: 'Sign in with Facebook',
              color: fbColor,
              width: 220,
              leading: SvgPicture.asset(
                Assets.svgImages.facebook,
                width: 25,
              ),
            ),
            verticalSpace8,
            PrimaryButton(
              onPressed: onLoginWithGoogle,
              label: 'Sign in with Google',
              labelColor: Colors.black,
              color: Colors.white,
              width: 220,
              border: Border.all(color: Colors.black),
              leading: SvgPicture.asset(
                Assets.svgImages.google,
                width: 25,
              ),
            ),
            verticalSpace8,
            const VerticalSpace(defaultHalfSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyles.label1,
                ),
                InkWell(
                  onTap: () => context.pushNamed(SignUpConnector.routeName),
                  child: Text(
                    'Sign up!',
                    style: TextStyles.label1.copyWith(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
