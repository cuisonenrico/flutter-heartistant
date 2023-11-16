import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';

abstract class AuthenticationHandler {
  Future<void> authStateChanges();

  Future<void> signOut();

  Future<UserDto?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String confirmPassword,
    required String displayName,
  });

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
