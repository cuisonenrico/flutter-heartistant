import 'package:flutter/cupertino.dart';
import 'package:flutter_authentication/features/sign_up/sign_up.dart';

class SignUpConnector extends StatelessWidget {
  const SignUpConnector({super.key});

  static const route = 'sign-up-page';
  static const routeName = 'sign-up-page';

  @override
  Widget build(BuildContext context) {
    return const SignUpScreen();
  }
}
