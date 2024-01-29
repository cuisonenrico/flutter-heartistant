import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/app_bar.dart';
import 'package:flutter_heartistant/features/widgets/app_scaffold.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  static const route = 'chat-room';
  static const routeName = 'chat-room';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MyAppBar(
        label: 'Person Name here',
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
                  ...List.generate(
                    14,
                    (index) => Row(
                      mainAxisAlignment: index % 2 == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: const [Text('Text sample ')],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Message preview
          Container(height: 50, color: Colors.blueGrey),
        ],
      ),
    );
  }
}
