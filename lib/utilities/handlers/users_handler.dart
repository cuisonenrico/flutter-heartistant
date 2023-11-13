import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_authentication/state/user_state/user_dto/user_dto.dart';
import 'package:flutter_authentication/utilities/handlers/base/firestore_users.dart';
import 'package:flutter_authentication/utilities/handlers/db_constants.dart';

class UsersHandler implements FirestoreUsers {
  UsersHandler();

  CollectionReference<Map<String, dynamic>> db = FirebaseFirestore.instance.collection(USER_COLLECTION);

  @override
  Future<UserDto?> userLogin(User user) async {
    // Queries db if id exists
    final isUserExist = await db.doc(user.uid).get().then((value) => value.exists);

    if (!isUserExist) {
      final newUser = <String, dynamic>{
        "uid": user.uid,
        "email": user.email,
      };

      // Creates entity when user does not exist in database
      await db.doc(user.uid).set(newUser);
    }

    return UserDto.fromFirestoreUser(user);
  }
}
