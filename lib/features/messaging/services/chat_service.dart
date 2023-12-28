import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:flutter_heartistant/utilities/handlers/db_constants.dart';

class ChatService extends ChangeNotifier {
  // final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  Future<List<UserDto>> getUserList() async {
    final collection = await _fireStore.collection(USER_COLLECTION).get();
    final userList = collection.docs.map((snapshot) => UserDto.fromJson(snapshot.data())).toList();

    return userList;
  }
}
