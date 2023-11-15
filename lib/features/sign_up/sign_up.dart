import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/app_bar.dart';
import 'package:flutter_heartistant/features/widgets/app_scaffold.dart';
import 'package:flutter_heartistant/features/widgets/input_field.dart';
import 'package:flutter_heartistant/features/widgets/primary_button.dart';
import 'package:flutter_heartistant/gen/assets.gen.dart';
import 'package:flutter_heartistant/utilities/colors.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double _signUpButtonWidth = 220.0;
const double _signUpIconSize = 25.0;

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
    const verticalSpaceHalf = VerticalSpace(defaultHalfSpacing);
    const verticalSpaceQuarter = VerticalSpace(defaultQuarterSpacing);

    return AppScaffold(
      appBar: const MyAppBar(
        backIconSubstitute: Icons.close,
        isSecondaryIconVisible: false,
        label: '',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultHalfPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account,',
                style: TextStyles.label1,
              ),
              const VerticalSpace(defaultQuarterSpacing),
              Text(
                'Sign up to get started!',
                style: TextStyles.label2,
              ),
              verticalSpaceHalf,
              Row(
                children: [
                  Flexible(
                    child: InputField(
                      onChangeText: (_) {},
                      hintText: 'First Name',
                    ),
                  ),
                  const HorizontalSpace(defaultHalfSpacing),
                  Flexible(
                    child: InputField(
                      onChangeText: (_) {},
                      hintText: 'Last Name',
                    ),
                  ),
                ],
              ),
              verticalSpaceHalf,
              InputField(
                onChangeText: (email) => onChangeEmail(email),
                hintText: 'Email',
                icon: Icons.email,
              ),
              verticalSpaceHalf,
              InputField(
                obscureText: true,
                onChangeText: (password) => onChangePassword(password),
                hintText: 'Password',
                icon: Icons.lock,
              ),
              verticalSpaceHalf,
              InputField(
                obscureText: true,
                onChangeText: (confirmPassword) => onChangeConfirmPassword(confirmPassword),
                hintText: 'Confirm Password ',
                icon: Icons.lock_open_outlined,
              ),
              verticalSpaceHalf,
              Row(
                children: [
                  Radio<bool>(
                    value: false, // assign boolean in state
                    groupValue: true,
                    onChanged: (value) {},
                  ),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyles.body2,
                        children: <TextSpan>[
                          const TextSpan(text: 'I have read and accept the '),
                          TextSpan(
                            text: 'Terms of Service ',
                            style: TextStyles.body2.copyWith(
                              color: Colors.blueAccent,
                            ),
                          ),
                          const TextSpan(text: 'and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyles.body2.copyWith(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpaceHalf,
              Center(
                child: Column(
                  children: [
                    PrimaryButton(
                      onPressed: () {},
                      label: signUpLabel,
                      color: Colors.blueAccent,
                      width: _signUpButtonWidth,
                    ),
                    verticalSpaceQuarter,
                    PrimaryButton(
                      onPressed: () {},
                      label: signInWithFacebookLabel,
                      color: fbColor,
                      width: _signUpButtonWidth,
                      leading: SvgPicture.asset(
                        Assets.svgImages.facebook,
                        width: _signUpIconSize - 10.0,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                    verticalSpaceQuarter,
                    PrimaryButton(
                      onPressed: () {},
                      label: signInWithGoogleLabel,
                      labelColor: Colors.black,
                      color: Colors.white,
                      width: _signUpButtonWidth,
                      border: Border.all(color: Colors.black),
                      leading: SvgPicture.asset(
                        Assets.svgImages.google,
                        width: _signUpIconSize,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
