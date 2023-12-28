import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/messaging/chat_room/chat_room.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/app_bar.dart';
import 'package:flutter_heartistant/features/widgets/app_scaffold.dart';
import 'package:flutter_heartistant/features/widgets/floating_container.dart';
import 'package:flutter_heartistant/features/widgets/input_field.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';
import 'package:go_router/go_router.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    required this.userList,
    super.key,
  });

  final List<UserDto> userList;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MyAppBar(
        label: 'Messages',
        labelTextStyle: TextStyles.headline2.copyWith(color: Colors.black),
        isSecondaryIconVisible: false,
        isMessagingIconVisible: false,
      ),
      floatingActionButton: const CircleAvatar(
        radius: 30,
        child: Icon(
          Icons.add,
          size: 30.0,
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
                  ...userList.map(
                    (user) => FloatingContainer(
                      padding: const EdgeInsets.only(
                        top: defaultHalfPadding,
                        bottom: defaultHalfPadding,
                        left: defaultQuarterPadding,
                        right: defaultQuarterPadding,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // TODO: pass the id of the chat room / create chat room from user's Id and recipient's Id
                          context.pushNamed(ChatRoom.routeName);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 25,
                            ),
                            const HorizontalSpace(defaultHalfSpacing),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.displayName ?? emptyString),
                                const VerticalSpace(defaultQuarterSpacing),
                                Text(
                                  'Latest Message',
                                  style: TextStyles.body2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
