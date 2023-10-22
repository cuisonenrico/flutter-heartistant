import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_authentication/utilities/login/base/authentication_handler.dart';

class AuthenticationHandlerImpl implements AuthenticationHandler {
  AuthenticationHandlerImpl();

  @override
  Future<void> authStateChanges() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    return;
  }

  @override
  Future<void> signOut() async => await FirebaseAuth.instance.signOut().then((_) => authStateChanges());

  @override
  Future<UserCredential> createUserWithEmailAndPassword({required String email, required String password}) async {
    final userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCred;
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    authStateChanges();
    return userCred;
  }
}
