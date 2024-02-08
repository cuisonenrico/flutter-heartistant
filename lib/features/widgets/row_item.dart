import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class RowItem extends StatelessWidget {
  const RowItem({
    required this.label,
    required this.value,
    required this.icon,
    super.key,
  });

  final String label;
  final Widget? value;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: defaultQuarterPadding,
        horizontal: defaultHalfPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                icon ?? const Icon(Icons.show_chart),
                const HorizontalSpace(4.0),
                Text(label),
              ],
            ),
          ),
          Expanded(
            child: value ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
