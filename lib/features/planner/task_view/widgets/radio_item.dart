import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class RadioItem<T> extends StatelessWidget {
  const RadioItem({
    required this.onChanged,
    required this.value,
    required this.groupValue,
    required this.label,
    this.color,
    super.key,
  });

  final T value;
  final T groupValue;
  final String? label;
  final ValueChanged<T> onChanged;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Radio<T>(
            activeColor: color?.withOpacity(0.7) ?? Colors.lightBlueAccent.withOpacity(0.7),
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            groupValue: groupValue,
            onChanged: (_) => onChanged(groupValue),
          ),
          const HorizontalSpace(defaultQuarterSpacing),
          Text(
            label ?? emptyString,
            style: TextStyles.label2,
          ),
        ],
      ),
    );
  }
}
