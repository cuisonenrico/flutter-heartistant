import 'package:flutter/material.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';

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
    return GestureDetector(
      onTap: callback,
      child: Row(
        children: [
          const CircleAvatar(),
          Text(displayName ?? emptyString),
        ],
      ),
    );
  }
}
