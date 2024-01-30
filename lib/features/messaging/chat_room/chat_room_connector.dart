import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/features/messaging/chat_room/chat_room.dart';
import 'package:flutter_heartistant/features/messaging/chat_room/chat_room_vm.dart';
import 'package:flutter_heartistant/state/actions/chat_page_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';

class ChatRoomConnector extends StatelessWidget {
  const ChatRoomConnector({
    required this.roomId,
    super.key,
  });

  static const route = 'chat-room';
  static const routeName = 'chat-room';

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChatRoomVm>(
      onInit: (store) => store.dispatch(SelectChatRoomAction(chatRoomId: roomId)),
      onDispose: (store) => store.dispatch(DisposeSelectedChatRoomIdAction()),
      vm: () => ChatRoomVmFactory(roomId),
      builder: (_, vm) => ChatRoom(
        onChatMessage: vm.onChatMessage,
        onChatChanged: vm.onChatChanged,
        chatDraft: vm.chatDraft,
        sender: vm.sender,
        recipient: vm.recipient,
        chatRoom: vm.chatRoom,
      ),
    );
  }
}
