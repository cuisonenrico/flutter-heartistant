import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/messaging/chat_room/chat_room_connector.dart';
import 'package:flutter_heartistant/features/messaging/chat_room/widgets/chat_room_box.dart';
import 'package:flutter_heartistant/features/messaging/create_chat_room_page/create_chat_room_page_connector.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/app_bar.dart';
import 'package:flutter_heartistant/features/widgets/app_scaffold.dart';
import 'package:flutter_heartistant/features/widgets/input_field.dart';
import 'package:flutter_heartistant/state/chat_page_state/chat_room_dto/chat_room_dto.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';
import 'package:go_router/go_router.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    required this.chatRooms,
    required this.users,
    super.key,
  });

  final List<ChatRoomDto> chatRooms;
  final List<UserDto> users;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MyAppBar(
        label: 'Messages',
        labelTextStyle: TextStyles.headline2.copyWith(color: Colors.black),
        isSecondaryIconVisible: false,
        isMessagingIconVisible: false,
      ),
      floatingActionButton: GestureDetector(
        onTap: () => context.pushNamed(CreateChatRoomConnector.routeName),
        child: const CircleAvatar(
          radius: 30,
          child: Icon(
            Icons.add,
            size: 30.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultHalfPadding),
            child: InputField(
              hintText: 'Search',
              onChangeText: (_) {},
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...chatRooms.map(
                    (room) => ChatRoomBox(
                      callback: () => context.pushNamed(ChatRoomConnector.routeName, extra: room.roomId),
                      displayName: users
                              .firstWhere(
                                  (element) => element.uid == room.recipientId || element.uid == room.roomCreatorId)
                              .displayName ??
                          emptyString,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
