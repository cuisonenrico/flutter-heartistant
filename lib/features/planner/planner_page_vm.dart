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
        selectedDay: state.plannerPageState.selectedDay,
        selectedMonth: state.plannerPageState.selectedMonth,
        tasks: state.plannerPageState.tasks,
      );

  void _onSelectDay(int selectedDay) => dispatch(SelectDayAction(selectedDay));

  void _onSelectMonth(int selectedMonth) => dispatch(SelectMonthAction(selectedMonth));

  // void _onResetDate() => dispatch(ResetSelectedDatesAction());
}

class PlannerPageVm extends Vm {
  PlannerPageVm({
    required this.onSelectDay,
    required this.onSelectMonth,
    required this.selectedDay,
    required this.selectedMonth,
    required this.tasks,
  }) : super(equals: [
          selectedDay,
          selectedMonth,
          tasks,
        ]);

  final ValueChanged<int> onSelectDay;
  final ValueChanged<int> onSelectMonth;

  final int selectedDay;
  final int selectedMonth;

  final List<TaskDto>? tasks;
}
