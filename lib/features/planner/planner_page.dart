import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_heartistant/features/planner/create_plan_page/create_plan_page_connector.dart';
import 'package:flutter_heartistant/features/planner/widgets/day_picker.dart';
import 'package:flutter_heartistant/features/planner/widgets/month_picker.dart';
import 'package:flutter_heartistant/features/planner/widgets/task_list.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/state/planner_page_state/models/task_dto.dart';
import 'package:flutter_heartistant/utilities/enums/page_view_enum.dart';
import 'package:flutter_heartistant/utilities/extensions/theme_extensions.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({
    required this.onSelectDay,
    required this.onSelectMonth,
    required this.onSelectYear,
    required this.onSelectTask,
    required this.selectedDay,
    required this.selectedMonth,
    required this.selectedYear,
    required this.tasks,
    this.isCreatingTask = true,
    super.key,
  });

  final ValueChanged<int> onSelectDay;
  final ValueChanged<int> onSelectMonth;
  final ValueChanged<int> onSelectYear;
  final ValueChanged<int> onSelectTask;

  final int selectedDay;
  final int selectedMonth;
  final int selectedYear;
  final bool isCreatingTask;

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
            child: Animate(
              effects: const [SlideEffect(duration: Duration(milliseconds: 300))],
              child: Column(
                children: [
                  MonthPicker(
                    selectedMonth: widget.selectedMonth,
                    selectedYear: widget.selectedYear,
                    onSelectMonth: widget.onSelectMonth,
                    onSelectYear: widget.onSelectYear,
                  ),
                  DayPicker(
                    color: pageThemeColor.getElementColor,
                    // TODO: handle in state
                    selectedDay: widget.selectedDay,
                    selectedMonth: widget.selectedMonth,
                    onSelectDay: widget.onSelectDay,
                  ),
                  const VerticalSpace(90.0),
                ],
              ),
            ),
          ),
        ),
        // TODO: Put in a separate widget
        Positioned(
          top: _topPosition,
          left: 0,
          right: 0,
          bottom: 0,
          child: TaskList(
            tasks: widget.tasks ?? [],
            onSelectTask: widget.onSelectTask,
          ),
        ),
        if (widget.isCreatingTask)
          Animate(
            effects: const [
              SlideEffect(
                duration: Duration(milliseconds: 400),
                end: Offset(0, 0),
                begin: Offset(0, 1),
              )
            ],
            child: const Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: CreatePlanPageConnector(),
            ),
          ),
      ],
    );
  }
}
