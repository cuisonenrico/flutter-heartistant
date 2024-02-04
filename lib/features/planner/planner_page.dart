import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/planner/widgets/day_picker.dart';
import 'package:flutter_heartistant/features/planner/widgets/month_picker.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/floating_container.dart';
import 'package:flutter_heartistant/state/planner_page_state/models/task_dto.dart';
import 'package:flutter_heartistant/utilities/decorations.dart';
import 'package:flutter_heartistant/utilities/enums/page_view_enum.dart';
import 'package:flutter_heartistant/utilities/enums/planner_page_enums.dart';
import 'package:flutter_heartistant/utilities/extensions/theme_extensions.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({
    required this.onSelectDay,
    required this.onSelectMonth,
    required this.selectedDay,
    required this.selectedMonth,
    required this.tasks,
    super.key,
  });

  final ValueChanged<int> onSelectDay;
  final ValueChanged<int> onSelectMonth;

  final int selectedDay;
  final int selectedMonth;

  final List<TaskDto>? tasks;

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  late GlobalKey _dateWidgetKey;
  late double _topPosition;

  @override
  void initState() {
    _dateWidgetKey = GlobalKey();
    _topPosition = 0.0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _dateWidgetKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _topPosition = renderBox.size.height - defaultSpacing;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageThemeColor = PageViewList.PLANNER.color;
    return Stack(
      children: [
        // TODO: Put in a separate widget
        Positioned(
          key: _dateWidgetKey,
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: PageViewList.PLANNER.color,
            child: Column(
              children: [
                MonthPicker(
                  selectedMonth: widget.selectedMonth,
                  onSelectMonth: widget.onSelectMonth,
                ),
                DayPicker(
                  color: pageThemeColor.getElementColor,
                  // TODO: handle in state
                  selectedDay: widget.selectedDay,
                  selectedMonth: widget.selectedMonth,
                  onSelectDay: widget.onSelectDay,
                ),
                const VerticalSpace(64),
              ],
            ),
          ),
        ),
        // TODO: Put in a separate widget
        Positioned(
          top: _topPosition,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(defaultRadius)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(6, 0),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(defaultSpacing),
                  if (widget.tasks != null)
                    ...widget.tasks!.map(
                      (task) => FloatingContainer(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [defaultShadow],
                          border: Border(
                            left: BorderSide(
                              width: 8.0,
                              color: TaskProgress.values[task.progress ?? 0].color,
                            ),
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding,
                          vertical: defaultQuarterPadding,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultHalfPadding,
                          vertical: defaultPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  task.title ?? emptyString,
                                  style: TextStyles.label1,
                                ),
                                const Icon(
                                  Icons.check_box_outline_blank,
                                  size: 25,
                                ),
                              ],
                            ),
                            const VerticalSpace(defaultQuarterSpacing),
                            Text(
                              task.note ?? emptyString,
                              style: TextStyles.body2,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
