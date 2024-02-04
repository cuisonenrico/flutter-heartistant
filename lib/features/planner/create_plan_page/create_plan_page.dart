import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class CreatePlanPage extends StatelessWidget {
  const CreatePlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpace(defaultSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    const Icon(
                      Icons.chevron_left,
                      size: 35.0,
                    ),
                    Text(
                      'Back',
                      style: TextStyles.label1,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.ios_share),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.circle_outlined),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text('Done'),
                  ),
                  const HorizontalSpace(defaultHalfSpacing),
                ],
              )
            ],
          ),
          const Divider(thickness: 3.0),
          const VerticalSpace(defaultSpacing),
          const SingleChildScrollView(
            child: Column(
              children: [
                // DatePickerDialog(
                //   initialDate: DateTime.now(),
                //   firstDate: DateTime(2024, 1, 1),
                //   lastDate: DateTime(2024, 12, 30),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
