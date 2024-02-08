import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/features/planner/task_view/task_view.dart';
import 'package:flutter_heartistant/features/planner/task_view/task_view_vm.dart';
import 'package:flutter_heartistant/state/app_state.dart';

class TaskViewConnector extends StatelessWidget {
  const TaskViewConnector({super.key});

  static const route = 'task-view';
  static const routeName = 'task-view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskViewVm>(
      vm: () => TaskViewVmFactory(),
      builder: (_, vm) => TaskView(
        task: vm.task,
        onChangeProgress: vm.onChangeProgress,
      ),
    );
  }
}
