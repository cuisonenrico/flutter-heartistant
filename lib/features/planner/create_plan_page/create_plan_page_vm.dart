import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/planner/create_plan_page/create_plan_page_connector.dart';
import 'package:flutter_heartistant/state/actions/planner_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/utilities/enums/planner_page_enums.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/typedefs.dart';

class CreatePlanPageVmFactory extends VmFactory<AppState, CreatePlanPageConnector, CreatePlanPageVm> {
  @override
  fromStore() => CreatePlanPageVm(
        onBackPressed: _onBackPressed,
        onCreateTask: _onCreateTask,
        onChangeDate: _onChangeDate,
        onChangeTime: _onChangeTime,
        onChangeTitle: _onChangeTitle,
        onChangeNotes: _onChangeNotes,
        date: state.createTaskState.date,
        time: _time,
      );

  String? get _time => state.createTaskState.startTime == null && state.createTaskState.endTime == null
      ? null
      : '${state.createTaskState.startTime ?? emptyString} ${state.createTaskState.endTime == null ? emptyString : '-'} ${state.createTaskState.endTime ?? emptyString}';

  void _onBackPressed() => dispatch(SetCreateTaskAction());

  void _onChangeDate(DateTime date) => dispatch(OnChangeDateAction(date));

  void _onChangeTime(TimeRange type, DateTime time) => dispatch(OnChangeTimeAction(
        type: type,
        pickedTime: time,
      ));

  void _onChangeTitle(String title) => dispatch(OnChangeTitleAction(title));

  void _onChangeNotes(String notes) => dispatch(OnChangeNotesAction(notes));

  void _onCreateTask() => dispatch(CreateTasksAction());
}

class CreatePlanPageVm extends Vm {
  CreatePlanPageVm({
    required this.onBackPressed,
    required this.onCreateTask,
    required this.onChangeDate,
    required this.onChangeTime,
    required this.onChangeTitle,
    required this.onChangeNotes,
    required this.date,
    required this.time,
  }) : super(equals: [
          date,
          time,
        ]);

  final VoidCallback onBackPressed;
  final VoidCallback onCreateTask;
  final ValueChanged<DateTime> onChangeDate;
  final OnChangeTime onChangeTime;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeNotes;

  final String? date;
  final String? time;
}
