import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_heartistant/features/messaging/services/chat_service.dart';
import 'package:flutter_heartistant/state/actions/actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';

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

    final ids = [uid, recipientId];
    ids.sort();
    final roomId = ids.join();

    // Checks if a chatroom between users already exists. if any, will not create a chatroom
    if (state.chatPageState.chatRooms.any((element) => element.roomId == roomId)) {
      // redirects to the chat room instead; ends the action;
      dispatch(ChatRoomExistsAction(roomId));
      return state;
    }

    final newChatRoom = await ChatService().createChatRoom(
      uid: uid,
      recipientId: recipientId,
    );

    if (newChatRoom == null) return state;

    return state.copyWith.chatPageState(chatRooms: [
      ...state.chatPageState.chatRooms,
      ...[newChatRoom],
    ]);
  }
}

/// Creates a Chat message between two users and stores in ChatRoom Array
class ChatMessageAction extends LoadingAction {
  ChatMessageAction() : super(actionKey: key);

  static const key = 'chat-message';

  @override
  Future<AppState> reduce() async {
    final selectedChatRoom = state.chatPageState.selectedChatRoom;
    if (selectedChatRoom == null) return state;

    final chatDraft = state.chatPageState.chatDraft;

    if (chatDraft == null) return state;

    final chatMessage = await ChatService().createChatMessage(
      roomId: selectedChatRoom.roomId ?? emptyString,
      senderId: state.userState.user.uid,
      message: chatDraft,
    );

    if (chatMessage == null) return state;

    return state.copyWith.chatPageState(
        selectedChatRoom: selectedChatRoom.copyWith(messages: [
      ...selectedChatRoom.messages,
      ...[chatMessage]
    ]));
  }

  @override
  void after() => dispatch(DisposeChatDraftAction());
}

/// Selects a chatroom and stores the selected chat room's Id in state
class SelectChatRoomAction extends ReduxAction<AppState> {
  SelectChatRoomAction({required this.chatRoomId});

  final String? chatRoomId;

  @override
  Future<AppState> reduce() async {
    if (chatRoomId == null) return state;
    final chatRoom = state.chatPageState.chatRooms.firstOrNullWhere((element) => element.roomId == chatRoomId);

    final chatMessages = await ChatService().getChatMessages(chatRoomId!);

    // Non existing chat rooms will not have any messages, return without messages.
    if (chatRoom == null || chatMessages == null) return state.copyWith.chatPageState(selectedChatRoom: chatRoom);

    return state.copyWith.chatPageState(selectedChatRoom: chatRoom.copyWith(messages: chatMessages));
  }
}

/// Clears selected Chat room id from state
class DisposeSelectedChatRoomIdAction extends ReduxAction<AppState> {
  DisposeSelectedChatRoomIdAction();

  @override
  AppState reduce() => state.copyWith.chatPageState(selectedChatRoom: null, chatDraft: null);
}

/// Clears selected Chat Draft from state
class DisposeChatDraftAction extends ReduxAction<AppState> {
  DisposeChatDraftAction();

  @override
  AppState reduce() => state.copyWith.chatPageState(chatDraft: null);
}

/// Stores chat message in state
class SetChatMessageDraftAction extends ReduxAction<AppState> {
  SetChatMessageDraftAction(this.message);

  final String? message;

  @override
  AppState reduce() => state.copyWith.chatPageState(chatDraft: message);
}
