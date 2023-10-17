import 'package:flutter/cupertino.dart';
import 'package:flutter_authentication/features/login/login_screen.dart';

class LoginScreenConnector extends StatelessWidget {
  const LoginScreenConnector({super.key});

  static const route = '/login-page';
  static const routeName = 'login-page';

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
