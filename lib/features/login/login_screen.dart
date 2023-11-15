import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/sign_up/sign_up_connector.dart';
import 'package:flutter_authentication/features/styles/spacers.dart';
import 'package:flutter_authentication/features/styles/styles.dart';
import 'package:flutter_authentication/features/widgets/app_scaffold.dart';
import 'package:flutter_authentication/features/widgets/input_field.dart';
import 'package:flutter_authentication/features/widgets/primary_button.dart';
import 'package:flutter_authentication/gen/assets.gen.dart';
import 'package:flutter_authentication/utilities/colors.dart';
import 'package:flutter_authentication/utilities/string_constants.dart';
import 'package:flutter_authentication/utilities/widget_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

const double _logoSize = 150.0;
const double _signInButtonWidth = 220.0;
const double _signInIconSize = 25.0;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.pngImages.heartistantLogo.image(
                height: _logoSize,
                width: _logoSize,
              ),
              verticalSpace16,
              InputField(
                onChangeText: (identifier) => onChangeId(identifier),
                hintText: emailUsernameHint,
                icon: Icons.mail,
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              ),
              verticalSpace8,
              InputField(
                onChangeText: (password) => onChangePassword(password),
                obscureText: true,
                hintText: passwordHint,
                icon: Icons.lock,
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              ),
              verticalSpace8,
              PrimaryButton(
                onPressed: onLogin,
                label: signInLabel,
                color: Colors.blueAccent,
                width: _signInButtonWidth,
              ),
              verticalSpace8,
              PrimaryButton(
                onPressed: onLoginWithFacebook,
                label: signInWithFacebookLabel,
                color: fbColor,
                width: _signInButtonWidth,
                leading: SvgPicture.asset(
                  Assets.svgImages.facebook,
                  width: _signInIconSize - 10.0,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
              verticalSpace8,
              PrimaryButton(
                onPressed: onLoginWithGoogle,
                label: signInWithGoogleLabel,
                labelColor: Colors.black,
                color: Colors.white,
                width: _signInButtonWidth,
                border: Border.all(color: Colors.black),
                leading: SvgPicture.asset(
                  Assets.svgImages.google,
                  width: _signInIconSize,
                ),
              ),
              verticalSpace8,
              const VerticalSpace(defaultHalfSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    noAccountPrompt,
                    style: TextStyles.body1,
                  ),
                  InkWell(
                    onTap: () => context.pushNamed(SignUpConnector.routeName),
                    child: Text(
                      signUpLabel,
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
      ),
    );
  }
}
