import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/planner/planner_page_connector.dart';
import 'package:flutter_heartistant/state/actions/planner_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/state/planner_page_state/models/task_dto.dart';

class PlannerPageVmFactory extends VmFactory<AppState, PlannerPageConnector, PlannerPageVm> {
  @override
  fromStore() => PlannerPageVm(
        onSelectDay: _onSelectDay,
        onSelectMonth: _onSelectMonth,
        onSelectYear: _onSelectYear,
        selectedDay: state.plannerPageState.selectedDay,
        selectedMonth: state.plannerPageState.selectedMonth,
        selectedYear: state.plannerPageState.selectedYear,
        tasks: state.plannerPageState.tasks,
        isCreatingTask: state.mainPageState.isCreatingTask,
      );

  void _onSelectDay(int selectedDay) => dispatch(SelectDayAction(selectedDay));

  void _onSelectMonth(int selectedMonth) => dispatch(SelectMonthAction(selectedMonth));

  void _onSelectYear(int selectedYear) => dispatch(SelectYearAction(selectedYear));

  // void _onResetDate() => dispatch(ResetSelectedDatesAction());
}

class PlannerPageVm extends Vm {
  PlannerPageVm({
    required this.onSelectDay,
    required this.onSelectMonth,
    required this.onSelectYear,
    required this.selectedDay,
    required this.selectedMonth,
    required this.selectedYear,
    required this.tasks,
    required this.isCreatingTask,
  }) : super(equals: [
          selectedDay,
          selectedMonth,
          selectedYear,
          tasks,
          isCreatingTask,
        ]);

  final ValueChanged<int> onSelectDay;
  final ValueChanged<int> onSelectMonth;
  final ValueChanged<int> onSelectYear;

  final int selectedDay;
  final int selectedMonth;
  final int selectedYear;
  final bool isCreatingTask;

  final List<TaskDto>? tasks;
}
