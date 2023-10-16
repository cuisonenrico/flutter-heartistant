import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/login/login_screen.dart';

class AuthenticationApp extends StatelessWidget {
  const AuthenticationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const LoginScreen(),
    );
  }
}
