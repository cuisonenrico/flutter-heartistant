import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class LabeledInfo extends StatelessWidget {
  const LabeledInfo({
    required this.label,
    required this.info,
    super.key,
  });

  final String label;
  final String info;

  @override
  Widget build(BuildContext context) {
    const verticalSpaceQuarter = VerticalSpace(defaultQuarterSpacing);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.label1.copyWith(color: Colors.blue),
        ),
        verticalSpaceQuarter,
        Text(
          info,
          style: TextStyles.body1.copyWith(color: Colors.black),
        ),
        verticalSpaceQuarter,
      ],
    );
  }
}
