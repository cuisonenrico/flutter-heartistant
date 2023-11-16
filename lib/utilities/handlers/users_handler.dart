import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:flutter_heartistant/utilities/handlers/base/firestore_users.dart';
import 'package:flutter_heartistant/utilities/handlers/db_constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UsersHandler implements FirestoreUsers {
  UsersHandler();

  CollectionReference<Map<String, dynamic>> db = FirebaseFirestore.instance.collection(USER_COLLECTION);

  @override
  Future<UserDto?> userLogin(User? user, {String? displayName}) async {
    if (user == null) return null;
    // Queries db if id exists
    final isUserExist = await db.doc(user.uid).get().then((value) => value.exists);

    final newUser = <String, dynamic>{
      "uid": user.uid,
      "email": user.email,
      "displayName": displayName ?? user.displayName,
    };

    if (!isUserExist) {
      // Creates entity when user does not exist in database
      await db.doc(user.uid).set(newUser);

      await user.updateDisplayName(displayName);
    }

    return UserDto.fromJson(newUser);
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCred = await FirebaseAuth.instance.signInWithCredential(credential);

    // TODO: Test signing up with socials
    // await userLogin(userCred.user,displayName: userCred.user?.displayName,);
    // Once signed in, return the UserCredential
    return userCred;
  }

  @override
  Future<UserCredential?> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final token = loginResult.accessToken?.token;
    if (token == null) return null;

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(token);

    final userCred = FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    // TODO: Test signing up with socials
    // await userLogin(userCred.user,displayName: userCred.user?.displayName,);
    // Once signed in, return the UserCredential
    return userCred;
  }
}
