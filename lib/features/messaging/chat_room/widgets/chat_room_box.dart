import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/floating_container.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class ChatRoomBox extends StatelessWidget {
  const ChatRoomBox({
    required this.callback,
    required this.displayName,
    super.key,
  });

  final String displayName;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback.call(),
      child: FloatingContainer(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultHalfPadding,
          vertical: defaultQuarterPadding,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: add User profile image
            const CircleAvatar(radius: 25),
            const HorizontalSpace(defaultHalfSpacing),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayName),
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
    );
  }
}
