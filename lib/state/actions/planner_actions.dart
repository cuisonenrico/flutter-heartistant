import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:flutter_heartistant/features/planner/services/planner_service.dart';
import 'package:flutter_heartistant/state/actions/actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';

/// Sets the [selectedDay] in State
class SelectDayAction extends ReduxAction<AppState> {
  SelectDayAction(this.selectedDay);

  final int selectedDay;

  @override
  Future<AppState> reduce() async => state.copyWith.plannerPageState(selectedDay: selectedDay);

  @override
  void after() {
    dispatch(GetTasksAction());
    super.after();
  }
}

/// Sets the [selectedMonth] in State
class SelectMonthAction extends ReduxAction<AppState> {
  SelectMonthAction(this.selectedMonth);

  final int selectedMonth;

  @override
  AppState reduce() => state.copyWith.plannerPageState(selectedMonth: selectedMonth.abs() % 12);

  @override
  void after() {
    dispatch(GetTasksAction());
    super.after();
  }
}

/// Sets the [selectedMonth] in State
class ResetSelectedDatesAction extends ReduxAction<AppState> {
  ResetSelectedDatesAction();

  @override
  AppState reduce() => state.copyWith.plannerPageState(
        selectedDay: DateTime.now().day,
        selectedMonth: DateTime.now().month,
      );
}

/// Gets Tasks from Firestore and stores in state
class GetTasksAction extends LoadingAction {
  GetTasksAction() : super(actionKey: key);

  static const key = 'get-tasks-action';

  @override
  Future<AppState?> reduce() async {
    final uid = state.userState.user.uid;

    if (uid == null) return state;
    final date = DateTime.now();

    final tasks = await PlannerService().getTasks(
      uid,
      DateTime(
        date.year,
        state.plannerPageState.selectedMonth,
        state.plannerPageState.selectedDay,
      ),
    );

    return state.copyWith.plannerPageState(tasks: tasks);
  }
}
