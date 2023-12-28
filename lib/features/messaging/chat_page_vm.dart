import 'package:async_redux/async_redux.dart';
import 'package:flutter_heartistant/features/messaging/chat_page_connector.dart';
import 'package:flutter_heartistant/models/union_page_state.dart';
import 'package:flutter_heartistant/state/actions/chat_page_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';

class ChatPageVmFactory extends VmFactory<AppState, ChatPageConnector, ChatPageVm> {
  @override
  fromStore() => ChatPageVm(chatPageState: _getPageState());

  UnionPageState<List<UserDto>> _getPageState() {
    if (state.wait.isWaitingFor(GetUserListAction.key)) {
      return const UnionPageState.loading();
    } else if (state.chatPageState.userList.isNotEmpty) {
      return UnionPageState(state.chatPageState.userList);
    } else {
      return const UnionPageState.error("Can't load Users");
    }
  }
}

class ChatPageVm extends Vm {
  ChatPageVm({required this.chatPageState}) : super(equals: [chatPageState]);

  final UnionPageState<List<UserDto>> chatPageState;
}
