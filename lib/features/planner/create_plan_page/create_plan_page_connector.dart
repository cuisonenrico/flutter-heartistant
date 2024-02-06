import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/features/planner/create_plan_page/create_plan_page.dart';
import 'package:flutter_heartistant/features/planner/create_plan_page/create_plan_page_vm.dart';
import 'package:flutter_heartistant/state/actions/planner_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';

class CreatePlanPageConnector extends StatelessWidget {
  const CreatePlanPageConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreatePlanPageVm>(
      vm: () => CreatePlanPageVmFactory(),
      onInit: (store) => store.dispatch(InitializeCreateTaskFormAction()),
      onDispose: (store) => store.dispatch(DisposeCreateTaskFormAction()),
      builder: (_, vm) => CreatePlanPage(
        onBackPressed: vm.onBackPressed,
        onCreateTask: vm.onCreateTask,
        onChangeTime: vm.onChangeTime,
        onChangeDate: vm.onChangeDate,
        onChangeTitle: vm.onChangeTitle,
        onChangeNotes: vm.onChangeNotes,
        date: vm.date,
        time: vm.time,
      ),
    );
  }
}
