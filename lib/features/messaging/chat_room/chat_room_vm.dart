import 'package:async_redux/async_redux.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/messaging/chat_room/chat_room_connector.dart';
import 'package:flutter_heartistant/state/actions/chat_page_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/state/chat_page_state/chat_room_dto/chat_room_dto.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';

class ChatRoomVmFactory extends VmFactory<AppState, ChatRoomConnector, ChatRoomVm> {
  ChatRoomVmFactory(this.roomId);

  final String roomId;

  @override
  fromStore() => ChatRoomVm(
        onChatMessage: _onChatMessage,
        onChatChanged: _onChatChanged,
        chatDraft: state.chatPageState.chatDraft,
        chatRoom: _chatRoom,
        sender: _sender,
        recipient: _recipient,
      );

  ChatRoomDto? get _chatRoom => state.chatPageState.selectedChatRoom;

  UserDto get _sender => state.userState.user;

  UserDto? get _recipient => state.chatPageState.userList.firstOrNullWhere((user) => user.uid == _recipientId);

  String? get _recipientId => _sender.uid == _chatRoom?.recipientId
      ? _chatRoom?.roomId?.replaceAll(_chatRoom!.recipientId!, '')
      : _chatRoom?.roomId?.replaceAll(_chatRoom!.roomCreatorId!, '');

  Future<void> _onChatMessage() async => dispatch(ChatMessageAction());

  Future<void> _onChatChanged(String? message) async => dispatch(SetChatMessageDraftAction(message));
}

class ChatRoomVm extends Vm {
  ChatRoomVm({
    required this.onChatMessage,
    required this.onChatChanged,
    required this.chatDraft,
    required this.chatRoom,
    required this.sender,
    required this.recipient,
  }) : super(equals: [
          chatDraft,
          chatRoom,
          sender,
          recipient,
        ]);

  final VoidCallback onChatMessage;
  final ValueChanged<String> onChatChanged;
  final String? chatDraft;

  final ChatRoomDto? chatRoom;
  final UserDto sender;
  final UserDto? recipient;
}
