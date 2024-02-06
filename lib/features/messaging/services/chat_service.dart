import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/state/chat_page_state/chat_dto/chat_dto.dart';
import 'package:flutter_heartistant/state/chat_page_state/chat_room_dto/chat_room_dto.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:flutter_heartistant/utilities/handlers/db_constants.dart';

class ChatService extends ChangeNotifier {
  ChatService();

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

  Future<ChatDto?> createChatMessage({required String roomId, String? message, String? senderId}) async {
    try {
      await chatRoomDb.doc(roomId).update({
        "messages": FieldValue.arrayUnion([
          {
            "senderId": senderId,
            "message": message,
            "date": DateTime.now().toString(),
          }
        ])
      });
    } catch (e) {
      return null;
    }
    return ChatDto(
      senderId: senderId,
      message: message,
      date: DateTime.now().toString(),
    );
  }

  Future<List<ChatDto>?> getChatMessages(String chatRoomId) async {
    final collection = await chatRoomDb.get();
    final chatRoom = collection.docs.firstWhere((element) => element.id == chatRoomId).data();

    final messages = chatRoom['messages'];

    if (messages == null) return null;
    final chatList = (messages as List).map((e) => ChatDto.fromJson(e as Map<String, dynamic>)).toList();

    return chatList;
  }

  Stream<QuerySnapshot> getMessages(String senderId, String receiverId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String roomId = ids.join();

    return chatRoomDb.doc(roomId).collection('messages').snapshots();
  }
}
