import 'package:async_redux/async_redux.dart';
import 'package:flutter_heartistant/features/messaging/chat_page_connector.dart';
import 'package:flutter_heartistant/models/union_page_state.dart';
import 'package:flutter_heartistant/state/actions/chat_page_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/state/chat_page_state/chat_room_dto/chat_room_dto.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:flutter_heartistant/utilities/extensions/wait_extensions.dart';

class ChatPageVmFactory extends VmFactory<AppState, ChatPageConnector, ChatPageVm> {
  @override
  fromStore() => ChatPageVm(
        chatPageState: _getPageState(),
        users: _users,
      );

  List<UserDto> get _users => state.chatPageState.userList;

  UnionPageState<List<ChatRoomDto>> _getPageState() {
    if (state.wait.isWaitingForKeys([GetUserListAction.key, GetChatRoomsAction.key])) {
      return const UnionPageState.loading();
    } else if (state.chatPageState.userList.isNotEmpty) {
      return UnionPageState(state.chatPageState.chatRooms);
    } else {
      return const UnionPageState.error("Can't load Chat Rooms");
    }
  }
}

class ChatPageVm extends Vm {
  ChatPageVm({
    required this.chatPageState,
    required this.users,
  }) : super(equals: [
          chatPageState,
          users,
        ]);

  final UnionPageState<List<ChatRoomDto>> chatPageState;
  final List<UserDto> users;
}
