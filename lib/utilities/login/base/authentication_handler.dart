import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationHandler {
  Future<void> authStateChanges();

  Future<void> signOut();

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
