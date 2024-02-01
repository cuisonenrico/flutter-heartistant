import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/messaging/chat_room/widgets/message_pill.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/app_bar.dart';
import 'package:flutter_heartistant/features/widgets/app_scaffold.dart';
import 'package:flutter_heartistant/features/widgets/input_field.dart';
import 'package:flutter_heartistant/state/chat_page_state/chat_room_dto/chat_room_dto.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    required this.onChatMessage,
    required this.onChatChanged,
    required this.chatDraft,
    required this.sender,
    required this.recipient,
    required this.chatRoom,
    super.key,
  });

  final VoidCallback onChatMessage;
  final ValueChanged<String> onChatChanged;
  final String? chatDraft;
  final UserDto sender;
  final UserDto? recipient;
  final ChatRoomDto? chatRoom;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController()..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MyAppBar(
        label: widget.recipient?.displayName ?? emptyString,
        labelTextStyle: TextStyles.headline2.copyWith(color: Colors.black),
        isSecondaryIconVisible: false,
        isMessagingIconVisible: false,
      ),
      body: Column(
        children: [
          // Chat area
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  ...?widget.chatRoom?.messages.map(
                    (room) => Row(
                      children: [
                        room.senderId == widget.sender.uid
                            ? MessagePill(
                                showAvatar: false,
                                mainAxisAlignment: MainAxisAlignment.start,
                                message: room.message,
                                isSender: true,
                              )
                            : MessagePill(
                                showAvatar: false,
                                mainAxisAlignment: MainAxisAlignment.end,
                                message: room.message,
                                color: Colors.grey,
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Message preview
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(defaultHalfPadding),
                  child: InputField(
                    keyboardInput: TextInputType.multiline,
                    maxLines: null,
                    controller: controller,
                    hintText: 'Message...',
                    onChangeText: (text) => widget.onChatChanged(text),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.onChatMessage.call();
                    controller.clear();
                  },
                  child: const Icon(Icons.send),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
