import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:flutter_heartistant/utilities/handlers/users_handler.dart';
import 'package:flutter_heartistant/utilities/login/base/authentication_handler.dart';

class AuthenticationHandlerImpl implements AuthenticationHandler {
  AuthenticationHandlerImpl();

  @override
  Future<void> authStateChanges() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
      } else {}
    });
    return;
  }

  @override
  Future<void> signOut() async => await FirebaseAuth.instance.signOut();

  @override
  Future<UserDto?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String confirmPassword,
    required String displayName,
  }) async {
    final userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userDto = await UsersHandler().userLogin(
      userCred.user,
      displayName: displayName,
    );
    return userDto;
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCred;
  }
}
