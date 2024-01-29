import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/state/chat_page_state/chat_room_dto/chat_room_dto.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:flutter_heartistant/utilities/handlers/db_constants.dart';

class ChatService extends ChangeNotifier {
  // final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> chatRoomDb = FirebaseFirestore.instance.collection(CHAT_ROOM_COLLECTION);

  Future<List<UserDto>> getUserList() async {
    final collection = await _fireStore.collection(USER_COLLECTION).get();
    final userList = collection.docs.map((snapshot) => UserDto.fromJson(snapshot.data())).toList();

    return userList;
  }

  Future<List<ChatRoomDto>> getChatRooms({required String uid}) async {
    final collection = await chatRoomDb.get();
    final chatRooms = collection.docs.map((snapshot) => ChatRoomDto.fromJson(snapshot.data())).toList();

    return chatRooms.where((element) => element.recipientId == uid || element.roomCreatorId == uid).toList();
  }

  Future<ChatRoomDto?> createChatRoom({required String? uid, required String? recipientId}) async {
    if (uid == null || recipientId == null) return null;
    final chatRoomId = uid + recipientId;

    final newChatRoom = <String, dynamic>{
      "roomId": chatRoomId,
      "roomCreatorId": uid,
      "recipientId": recipientId,
      "creationDate": DateTime.now().toString(),
    };

    chatRoomDb.doc(chatRoomId).set(newChatRoom);

    return ChatRoomDto.fromJson(newChatRoom);
  }
}
