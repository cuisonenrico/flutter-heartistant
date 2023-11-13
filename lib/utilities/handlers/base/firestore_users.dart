import 'package:firebase_auth/firebase_auth.dart';

abstract class FirestoreUsers {
  Future<void> userLogin(User user);
}
