import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/expansion_tile.dart';
import 'package:flutter_heartistant/features/widgets/floating_container.dart';
import 'package:flutter_heartistant/features/widgets/input_field.dart';
import 'package:flutter_heartistant/utilities/enums/page_view_enum.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';
import 'package:intl/intl.dart';

const double _datePickerHeight = 150.0;

class CreatePlanPage extends StatelessWidget {
  const CreatePlanPage({
    required this.onBackPressed,
    required this.onCreateTask,
    required this.onChangeDate,
    required this.onChangeTime,
    required this.onChangeTitle,
    required this.onChangeNotes,
    this.time,
    this.date,
    super.key,
  });

  final VoidCallback onBackPressed;
  final VoidCallback onCreateTask;
  final ValueChanged<DateTime> onChangeDate;
  final ValueChanged<DateTime> onChangeTime;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeNotes;
  final String? date;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          const VerticalSpace(defaultSpacing),
          Positioned(
            top: 8.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => onBackPressed(),
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
              ],
            ),
          ),
          // const Divider(thickness: 3.0),
          // const VerticalSpace(defaultSpacing),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Radio<bool>(value: true, groupValue: true, onChanged: (_) {}),
                  Padding(
                    padding: const EdgeInsets.all(defaultHalfPadding),
                    child: InputField(
                      hintText: 'Title',
                      onChangeText: (title) => onChangeTitle(title),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultHalfPadding),
                    child: AppExpansionTile(
                      title: 'Date',
                      padding: EdgeInsets.zero,
                      onExpansionChanged: (_) {},
                      displayedText: DateFormat('yMMMMEEEEd').format(DateTime.parse(date!)).toString(),
                      displayedTextTextStyle: TextStyles.body1,
                      // icon: Assets.svgImages.chevronDown.svg(),
                      children: [
                        SizedBox(
                          height: _datePickerHeight,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: defaultQuarterPadding),
                            child: CupertinoDatePicker(
                              minimumYear: 2024,
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: date == null ? DateTime.now() : DateTime.parse(date!),
                              dateOrder: DatePickerDateOrder.dmy,
                              // This is called when the user changes the dateTime.
                              onDateTimeChanged: (date) => onChangeDate(date),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalSpace(defaultHalfSpacing),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultHalfPadding),
                    child: AppExpansionTile(
                      title: 'Time',
                      padding: EdgeInsets.zero,
                      onExpansionChanged: (_) {},
                      displayedText: time ?? emptyString,
                      displayedTextTextStyle: TextStyles.body1,
                      // icon: Assets.svgImages.chevronDown.svg(),
                      children: [
                        SizedBox(
                          height: _datePickerHeight,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: defaultQuarterPadding),
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.time,
                              initialDateTime: DateTime.now(),
                              // This is called when the user changes the dateTime.
                              onDateTimeChanged: (time) => onChangeTime(time),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultHalfPadding),
                    child: InputField(
                      keyboardInput: TextInputType.multiline,
                      maxLines: 4,
                      hintText: 'Notes',
                      onChangeText: (notes) => onChangeNotes(notes),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onCreateTask(),
                    child: FloatingContainer(
                      padding: const EdgeInsets.all(defaultHalfPadding),
                      decoration: defaultBoxDecorationWithShadow.copyWith(
                        color: PageViewList.PLANNER.color,
                      ),
                      child: Text(
                        'Create Task',
                        style: TextStyles.label1.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpace(defaultSpacing),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
