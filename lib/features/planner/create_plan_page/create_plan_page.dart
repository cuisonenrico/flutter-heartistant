import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/expansion_tile.dart';
import 'package:flutter_heartistant/features/widgets/floating_container.dart';
import 'package:flutter_heartistant/features/widgets/input_field.dart';
import 'package:flutter_heartistant/gen/assets.gen.dart';
import 'package:flutter_heartistant/utilities/enums/page_view_enum.dart';
import 'package:flutter_heartistant/utilities/enums/planner_page_enums.dart';
import 'package:flutter_heartistant/utilities/extensions/string_ext.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/typedefs.dart';
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
  final OnChangeTime onChangeTime;
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
                      inputDecoration: InputDecoration(
                        hintText: 'What are you doing?',
                        labelText: 'Title',
                        focusColor: PageViewList.PLANNER.color,
                        labelStyle: TextStyles.label3.copyWith(color: PageViewList.PLANNER.color),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: PageViewList.PLANNER.color), // Define underline color
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: PageViewList.PLANNER.color), // Define underline color
                        ),
                      ),
                      onChangeText: (title) => onChangeTitle(title),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultHalfPadding),
                    child: AppExpansionTile(
                      title: 'Date',
                      titleStyle: TextStyles.label3.copyWith(color: PageViewList.PLANNER.color),
                      padding: EdgeInsets.zero,
                      onExpansionChanged: (_) {},
                      displayedText: DateFormat('yMMMMEEEEd').format(DateTime.parse(date!)).toString(),
                      displayedTextTextStyle: TextStyles.body1,
                      icon: Assets.svgImages.chevronDown.svg,
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
                      titleStyle: TextStyles.label3.copyWith(color: PageViewList.PLANNER.color),
                      padding: EdgeInsets.zero,
                      onExpansionChanged: (_) {},
                      displayedText: time ?? 'What Time?',
                      displayedTextTextStyle: TextStyles.body1,
                      icon: Assets.svgImages.chevronDown.svg,
                      children: [
                        SizedBox(
                          height: _datePickerHeight,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: defaultQuarterPadding),
                                  child: CupertinoDatePicker(
                                    minuteInterval: 15,
                                    mode: CupertinoDatePickerMode.time,
                                    initialDateTime: DateTime.parse(date ?? emptyString),
                                    // This is called when the user changes the dateTime.
                                    onDateTimeChanged: (time) => onChangeTime(TimeRange.START_TIME, time),
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Center(
                                  child: Icon(Icons.arrow_right_alt),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: defaultQuarterPadding),
                                  child: CupertinoDatePicker(
                                    minuteInterval: 15,
                                    mode: CupertinoDatePickerMode.time,
                                    initialDateTime: DateTime.parse(date ?? emptyString),
                                    // This is called when the user changes the dateTime.
                                    onDateTimeChanged: (time) => onChangeTime(TimeRange.END_TIME, time),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultHalfPadding),
                    child: InputField(
                      keyboardInput: TextInputType.multiline,
                      maxLines: 2,
                      inputDecoration: InputDecoration(
                        hintText: 'Describe your task',
                        labelText: 'Notes',
                        focusColor: PageViewList.PLANNER.color,
                        labelStyle: TextStyles.label3.copyWith(color: PageViewList.PLANNER.color),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: PageViewList.PLANNER.color), // Define underline color
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: PageViewList.PLANNER.color), // Define underline color
                        ),
                      ),
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
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Create Task',
                          style: TextStyles.label1.copyWith(
                            color: Colors.white,
                          ),
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
