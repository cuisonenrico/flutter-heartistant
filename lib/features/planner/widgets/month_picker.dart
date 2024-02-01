import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:intl/intl.dart';

class MonthPicker extends StatelessWidget {
  const MonthPicker({
    required this.onSelectMonth,
    required this.selectedMonth,
    super.key,
  });

  final int selectedMonth;
  final ValueChanged<int> onSelectMonth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
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
    );
  }
}
