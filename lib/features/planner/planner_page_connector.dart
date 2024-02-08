import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/features/planner/planner_page.dart';
import 'package:flutter_heartistant/features/planner/planner_page_vm.dart';
import 'package:flutter_heartistant/state/actions/planner_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';

class PlannerPageConnector extends StatelessWidget {
  const PlannerPageConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PlannerPageVm>(
      vm: () => PlannerPageVmFactory(),
      onInit: (store) => store.dispatch(GetTasksAction()),
      builder: (_, vm) => PlannerPage(
        onSelectDay: vm.onSelectDay,
        onSelectMonth: vm.onSelectMonth,
        onSelectYear: vm.onSelectYear,
        onSelectTask: vm.onSelectTask,
        selectedDay: vm.selectedDay,
        selectedMonth: vm.selectedMonth,
        selectedYear: vm.selectedYear,
        isCreatingTask: vm.isCreatingTask,
        tasks: vm.tasks,
      ),
    );
  }
}
