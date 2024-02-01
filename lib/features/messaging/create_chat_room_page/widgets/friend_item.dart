import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({
    required this.displayName,
    required this.callback,
    super.key,
  });

  final String? displayName;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    // TODO: UI and Functionality Improvement
    return Padding(
      padding: const EdgeInsets.all(defaultQuarterPadding),
      child: GestureDetector(
        onTap: callback,
        child: Row(
          children: [
            const CircleAvatar(),
            const HorizontalSpace(defaultQuarterSpacing),
            Text(displayName ?? emptyString),
          ],
        ),
      ),
    );
  }
}
