import 'dart:async';

import 'package:flutter_heartistant/features/messaging/services/chat_service.dart';
import 'package:flutter_heartistant/state/actions/actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';

/// Gets the users in firestore and store in state
class GetUserListAction extends LoadingAction {
  GetUserListAction() : super(actionKey: key);

  static const key = 'get-users-action';

  @override
  Future<AppState> reduce() async {
    final userListAll = await ChatService().getUserList();

    final userList = userListAll.where((element) => element.uid != state.userState.user.uid).toList();

    return state.copyWith(chatPageState: state.chatPageState.copyWith(userList: userList));
  }
}

/// Gets the Chat Rooms Available in DB
class GetChatRoomsAction extends LoadingAction {
  GetChatRoomsAction() : super(actionKey: key);

  static const key = 'get-user-chat-rooms';

  @override
  Future<AppState> reduce() async {
    final chatRooms = await ChatService().getChatRooms(uid: state.userState.user.uid ?? '0');
    return state.copyWith(chatPageState: state.chatPageState.copyWith(chatRooms: chatRooms));
  }
}

/// Creates a Chat Room between two users
class CreateChatRoomAction extends LoadingAction {
  CreateChatRoomAction({required this.recipientId}) : super(actionKey: key);

  static const key = 'create-chat-room';

  final String? recipientId;
  @override
  Future<AppState> reduce() async {
    final uid = state.userState.user.uid;

    if (recipientId == null || uid == null) return state;

    final uid1 = uid + recipientId!;
    final uid2 = recipientId! + uid;

    // Checks if a chatroom between users already exists. if any, will not create a chatroom
    if (state.chatPageState.chatRooms.any((element) => element.roomId == uid1 || element.roomId == uid2)) return state;

    final newChatRoomId = await ChatService().createChatRoom(
      uid: uid,
      recipientId: recipientId,
    );

    if (newChatRoomId == null) return state;

    final chatRooms = [
      ...state.chatPageState.chatRooms,
      ...[newChatRoomId]
    ];

    return state.copyWith(chatPageState: state.chatPageState.copyWith(chatRooms: chatRooms));
  }
}
