import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/messaging/create_chat_room_page/create_chat_room_page_connector.dart';
import 'package:flutter_heartistant/state/actions/chat_page_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';

class CreateChatRoomVmFactory extends VmFactory<AppState, CreateChatRoomConnector, CreateChatRoomPageVm> {
  @override
  fromStore() => CreateChatRoomPageVm(
        onCreateChatRoom: _onCreateChatRoom,
        users: _users,
      );

  List<UserDto> get _users =>
      state.chatPageState.userList.where((element) => element.uid != state.userState.user.uid).toList();

  Future<void> _onCreateChatRoom(String? recipientId) async => dispatch(CreateChatRoomAction(recipientId: recipientId));
}

class CreateChatRoomPageVm extends Vm {
  CreateChatRoomPageVm({
    required this.onCreateChatRoom,
    required this.users,
  }) : super(equals: [users]);

  final List<UserDto> users;
  final ValueChanged<String?> onCreateChatRoom;
}
