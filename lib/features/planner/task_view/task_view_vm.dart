import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/features/planner/task_view/task_view_connector.dart';
import 'package:flutter_heartistant/state/actions/planner_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/utilities/enums/planner_page_enums.dart';

import '../../../state/planner_page_state/models/task_dto.dart';

class TaskViewVmFactory extends VmFactory<AppState, TaskViewConnector, TaskViewVm> {
  @override
  fromStore() => TaskViewVm(
        onChangeProgress: _onChangeProgress,
        task: state.plannerPageState.selectedTask,
      );

  void _onChangeProgress(TaskProgress progress) => dispatch(ProgressChangeAction(progress));
}

class TaskViewVm extends Vm {
  TaskViewVm({
    required this.onChangeProgress,
    required this.task,
  }) : super(equals: [task]);

  final TaskDto? task;
  final ValueChanged<TaskProgress> onChangeProgress;
}
