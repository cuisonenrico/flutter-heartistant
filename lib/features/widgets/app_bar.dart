import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/messaging/chat_page_connector.dart';
import 'package:flutter_heartistant/features/widgets/app_bar_label.dart';
import 'package:flutter_heartistant/features/widgets/app_icon_button.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';
import 'package:go_router/go_router.dart';

const double _backButtonSize = 25.0;

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    required this.label,
    this.onSecondaryActionPressed,
    this.onPressBack,
    this.secondaryActionIcon = Icons.menu,
    this.isSecondaryIconVisible = true,
    this.isMessagingIconVisible = true,
    this.isBackButtonVisible = true,
    this.labelTextStyle,
    this.subLabel,
    this.isCornersRounded = true,
    this.isShadowVisible = true,
    this.backIconSubstitute,
    super.key,
  });

  final VoidCallback? onSecondaryActionPressed;
  final VoidCallback? onPressBack;

  final bool isCornersRounded;
  final bool isSecondaryIconVisible;
  final bool isMessagingIconVisible;
  final bool isBackButtonVisible;
  final String label;
  final IconData secondaryActionIcon;
  final bool isShadowVisible;
  final TextStyle? labelTextStyle;
  final String? subLabel;
  final IconData? backIconSubstitute;

  double get _verticalPadding => subLabel != null ? defaultHalfPadding : defaultQuarterPadding;

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.of(context).viewPadding;

    return Container(
      // Padding for the device's status bar
      padding: EdgeInsets.only(top: viewPadding.top),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(isCornersRounded ? defaultHalfRadius : 0.0)),
        boxShadow: null,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: _verticalPadding,
          bottom: _verticalPadding,
          left: defaultHalfPadding,
        ),
        child: Row(
          children: [
            if (isBackButtonVisible)
              AppIconButton(
                icon: Icon(
                  backIconSubstitute ?? Icons.chevron_left_rounded,
                  size: _backButtonSize,
                  color: Colors.black,
                ),
                onPressed: onPressBack ?? context.pop,
              ),
            Expanded(
              child: AppBarLabel(
                label: label,
                subLabel: subLabel,
                labelTextStyle: labelTextStyle,
              ),
            ),
            if (isMessagingIconVisible)
              AppIconButton(
                onPressed: () {
                  context.pushNamed(ChatPageConnector.routeName);
                },
                icon: const Icon(Icons.message),
              ),
            if (isSecondaryIconVisible)
              AppIconButton(
                onPressed: onSecondaryActionPressed,
                icon: Icon(secondaryActionIcon),
              ),
          ],
        ),
      ),
    );
  }
}
