import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/features/messaging/create_chat_room_page/widgets/friend_item.dart';
import 'package:flutter_heartistant/features/widgets/app_bar.dart';
import 'package:flutter_heartistant/features/widgets/app_scaffold.dart';
import 'package:flutter_heartistant/features/widgets/input_field.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class CreateChatRoomPage extends StatelessWidget {
  const CreateChatRoomPage({
    required this.onCreateChatRoom,
    required this.friends,
    super.key,
  });

  final List<UserDto> friends;
  final ValueChanged<String?> onCreateChatRoom;

  @override
  Widget build(BuildContext context) {
    // TODO: UI and functionality improvements
    return AppScaffold(
      appBar: const MyAppBar(
        label: emptyString,
        isSecondaryIconVisible: false,
        isMessagingIconVisible: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultHalfPadding),
            child: InputField(
              hintText: 'Search',
              onChangeText: (_) {
                // TODO: add search functions
              },
            ),
          ),
          ...friends.map(
            (friend) => FriendItem(
              callback: () => onCreateChatRoom(friend.uid),
              displayName: friend.displayName,
            ),
          )
        ],
      ),
    );
  }
}
