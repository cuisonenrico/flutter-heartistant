import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/styles/spacers.dart';
import 'package:flutter_authentication/features/styles/styles.dart';
import 'package:flutter_authentication/utilities/widget_constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    required this.label,
    this.color,
    this.gradient,
    this.height,
    this.width,
    this.labelSize,
    this.suffix,
    this.leading,
    this.borderRadius,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final Color? color;
  final Gradient? gradient;
  final double? height;
  final double? width;
  final double? labelSize;
  final Widget? suffix;
  final Widget? leading;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? buttonHeight,
      width: width,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(defaultQuarterRadius),
      ),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
          FocusScope.of(context).requestFocus(FocusNode());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(defaultQuarterRadius)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              leading!,
              const HorizontalSpace(defaultQuarterSpacing),
            ],
            Text(
              label,
              style: TextStyles.primaryButtonText,
            ),
            if (suffix != null) ...[
              const HorizontalSpace(defaultHalfSpacing),
              suffix!,
            ]
          ],
        ),
      ),
    );
  }
}
