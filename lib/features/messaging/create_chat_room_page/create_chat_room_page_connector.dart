import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/features/messaging/create_chat_room_page/create_chat_room_page.dart';
import 'package:flutter_heartistant/features/messaging/create_chat_room_page/create_chat_room_page_vm.dart';
import 'package:flutter_heartistant/state/app_state.dart';

class CreateChatRoomConnector extends StatelessWidget {
  const CreateChatRoomConnector({super.key});

  static const route = 'create-chat-room';
  static const routeName = 'create-chat-room';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateChatRoomPageVm>(
      vm: () => CreateChatRoomVmFactory(),
      builder: (_, vm) => CreateChatRoomPage(
        onCreateChatRoom: vm.onCreateChatRoom,
        friends: vm.users,
      ),
    );
  }
}
