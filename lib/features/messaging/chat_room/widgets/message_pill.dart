import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class MessagePill extends StatelessWidget {
  const MessagePill({
    required this.message,
    this.showAvatar = true,
    this.color,
    this.isSender = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    super.key,
  });

  final Color? color;
  final String? message;
  final bool showAvatar;
  final bool isSender;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          const HorizontalSpace(defaultQuarterSpacing),
          if (isSender)
            Visibility(
              visible: showAvatar,
              child: const CircleAvatar(),
            ),
          const HorizontalSpace(defaultQuarterSpacing),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(bottom: defaultQuarterPadding),
              padding: const EdgeInsets.all(defaultQuarterPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: color ?? Colors.lightBlue,
              ),
              child: Text(
                message ?? emptyString,
                style: TextStyles.label1.copyWith(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          const HorizontalSpace(defaultQuarterSpacing),
          if (!isSender)
            Visibility(
              visible: showAvatar,
              child: const CircleAvatar(),
            ),
          const HorizontalSpace(defaultQuarterSpacing),
        ],
      ),
    );
  }
}
