import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';
import 'package:intl/intl.dart';

class MonthPicker extends StatelessWidget {
  const MonthPicker({
    required this.onSelectMonth,
    required this.onSelectYear,
    required this.selectedMonth,
    required this.selectedYear,
    super.key,
  });

  final int selectedMonth;
  final int selectedYear;
  final ValueChanged<int> onSelectMonth;
  final ValueChanged<int> onSelectYear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultQuarterPadding, vertical: defaultHalfPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => onSelectYear(selectedYear - 1),
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
              ),
              Text(
                DateFormat.y().format(DateTime(selectedYear)),
                style: TextStyles.label1.copyWith(
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () => onSelectYear(selectedYear + 1),
                icon: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => onSelectMonth(selectedMonth - 1),
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
              ),
              Text(
                DateFormat.MMMM().format(DateTime(0, selectedMonth)),
                style: TextStyles.label1.copyWith(
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () => onSelectMonth(selectedMonth + 1),
                icon: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
