import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';
import 'package:intl/intl.dart';

class DayPicker extends StatelessWidget {
  const DayPicker({
    required this.onSelectDay,
    required this.selectedMonth,
    required this.selectedDay,
    this.color,
    super.key,
  });

  final ValueChanged<int> onSelectDay;
  final Color? color;
  final int selectedDay;
  final int selectedMonth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultQuarterPadding),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(DateTime(2024, selectedMonth).daysInMonth, (index) {
            final isDaySelected = selectedDay == (index + 1);

            return GestureDetector(
              onTap: () => onSelectDay(index + 1),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                padding: const EdgeInsets.all(defaultQuarterPadding),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(defaultQuarterRadius)),
                  border: Border.all(color: isDaySelected ? Colors.black : color ?? Colors.black),
                  color: isDaySelected ? Colors.white : Colors.transparent,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 33.0,
                      child: Center(
                        child: Text(
                          DateFormat.E().format(DateTime(2024, selectedMonth, index + 1)),
                          style: TextStyles.label2.copyWith(color: isDaySelected ? Colors.black : color),
                        ),
                      ),
                    ),
                    Text(
                      '${index + 1}',
                      style: TextStyles.label2.copyWith(color: isDaySelected ? Colors.black : color),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
