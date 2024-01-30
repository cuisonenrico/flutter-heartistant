import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/features/messaging/chat_room/chat_room_connector.dart';
import 'package:flutter_heartistant/features/messaging/create_chat_room_page/create_chat_room_page.dart';
import 'package:flutter_heartistant/features/messaging/create_chat_room_page/create_chat_room_page_vm.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:go_router/go_router.dart';

class CreateChatRoomConnector extends StatelessWidget {
  const CreateChatRoomConnector({super.key});

  static const route = 'create-chat-room';
  static const routeName = 'create-chat-room';

  void _consumeEvents(BuildContext? context, CreateChatRoomPageVm vm) {
    if (vm.chatRoomExistsEvt?.isNotSpent == true) {
      final roomId = vm.chatRoomExistsEvt?.consume();
      context?.pushReplacementNamed(ChatRoomConnector.routeName, extra: roomId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateChatRoomPageVm>(
      onDidChange: (context, __, vm) => _consumeEvents(context, vm),
      vm: () => CreateChatRoomVmFactory(),
      builder: (_, vm) => CreateChatRoomPage(
        onCreateChatRoom: vm.onCreateChatRoom,
        // TODO: implement friends system
        friends: vm.users,
      ),
    );
  }
}
