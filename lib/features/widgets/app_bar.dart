import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/widgets/app_bar_label.dart';
import 'package:flutter_authentication/features/widgets/app_icon_button.dart';
import 'package:flutter_authentication/utilities/widget_constants.dart';
import 'package:go_router/go_router.dart';

const double _backButtonSize = 40.0;

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    required this.onSecondaryActionPressed,
    required this.label,
    this.onPressBack,
    this.secondaryActionIcon = Icons.menu,
    this.isSecondaryIconVisible = true,
    this.labelTextStyle,
    this.subLabel,
    this.isCornersRounded = true,
    this.isShadowVisible = true,
    super.key,
  });

  final VoidCallback onSecondaryActionPressed;
  final VoidCallback? onPressBack;

  final bool isCornersRounded;
  final bool isSecondaryIconVisible;
  final String label;
  final IconData secondaryActionIcon;
  final bool isShadowVisible;
  final TextStyle? labelTextStyle;
  final String? subLabel;

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
            AppIconButton(
              icon: const Icon(
                Icons.chevron_left_rounded,
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
            // if (!isProfilePage && !isLoginPage)
            //   AppIconButton(
            //     onPressed: () => context.pushNamed(ProfilePageConnector.routeName),
            //     icon: const Icon(Icons.person),
            //   ),
            // if (isSecondaryIconVisible)
            //   AppIconButton(
            //     onPressed: onSecondaryActionPressed,
            //     icon: Icon(secondaryActionIcon),
            //   ),
          ],
        ),
      ),
    );
  }
}
