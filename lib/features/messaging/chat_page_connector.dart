import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/features/messaging/chat_page.dart';
import 'package:flutter_heartistant/features/messaging/chat_page_vm.dart';
import 'package:flutter_heartistant/state/actions/chat_page_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';

class ChatPageConnector extends StatelessWidget {
  const ChatPageConnector({super.key});

  static const route = 'chat-page';
  static const routeName = 'chat-page';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChatPageVm>(
      vm: () => ChatPageVmFactory(),
      onInit: (store) async => store
        ..dispatch(GetUserListAction())
        ..dispatch(GetChatRoomsAction()),
      builder: (_, vm) => vm.chatPageState.when(
        (chatRooms) => ChatPage(
          chatRooms: chatRooms ?? [],
          users: vm.users,
        ),
        loading: () => const SizedBox(),
        error: (err) => Center(child: Text(err!)),
      ),
    );
  }
}
