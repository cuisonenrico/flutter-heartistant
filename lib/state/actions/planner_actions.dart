import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:flutter_heartistant/features/planner/services/planner_service.dart';
import 'package:flutter_heartistant/state/actions/actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/state/planner_page_state/models/task_dto.dart';
import 'package:flutter_heartistant/utilities/app_starter.dart';
import 'package:flutter_heartistant/utilities/enums/planner_page_enums.dart';
import 'package:flutter_heartistant/utilities/extensions/time_format_ext.dart';

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

/// Sets the [selectedYear] in State
class SelectYearAction extends ReduxAction<AppState> {
  SelectYearAction(this.selectedYear);

  final int selectedYear;

  @override
  AppState reduce() => state.copyWith.plannerPageState(selectedYear: selectedYear < 2024 ? 2024 : selectedYear);

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
        selectedYear: DateTime.now().year,
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

    final plannerPageState = state.plannerPageState;

    final tasks = await getIt<PlannerService>().getTasks(
      uid,
      DateTime(
        plannerPageState.selectedYear,
        plannerPageState.selectedMonth,
        plannerPageState.selectedDay,
      ),
    );

    return state.copyWith.plannerPageState(tasks: tasks);
  }
}

/// creates task
class CreateTasksAction extends LoadingAction {
  @override
  Future<AppState> reduce() async {
    final uid = state.userState.user.uid;

    if (uid == null) return state;

    final createTaskState = state.createTaskState;

    final time = createTaskState.startTime == createTaskState.endTime
        ? createTaskState.startTime
        : '${createTaskState.startTime} - ${createTaskState.endTime}';

    final id = state.plannerPageState.tasks?.length ?? 0;

    final task = TaskDto(
      id: id,
      title: createTaskState.title,
      note: createTaskState.notes,
      time: time,
      progress: 0,
    );

    final date = createTaskState.date == null ? DateTime.now() : DateTime.parse(createTaskState.date!);

    await getIt<PlannerService>().createTask(uid, date, task);

    return state;
  }

  @override
  void after() {
    dispatch(SelectDateAction());
    dispatch(SetCreateTaskAction());
    super.after();
  }
}

///
class SelectDateAction extends ReduxAction<AppState> {
  SelectDateAction();
  @override
  AppState reduce() {
    final dateFromCreation = state.createTaskState.date;
    if (dateFromCreation == null) return state;
    final date = DateTime.parse(dateFromCreation);

    return state.copyWith.plannerPageState(
      selectedYear: date.year,
      selectedDay: date.day,
      selectedMonth: date.month,
    );
  }

  @override
  void after() {
    dispatch(GetTasksAction());
    super.after();
  }
}

/// Sets [isCreatingTask] in state when user triggers Task creation
class SetCreateTaskAction extends ReduxAction<AppState> {
  SetCreateTaskAction();

  @override
  AppState reduce() => state.copyWith.mainPageState(isCreatingTask: !state.mainPageState.isCreatingTask);
}

///
class InitializeCreateTaskFormAction extends ReduxAction<AppState> {
  InitializeCreateTaskFormAction();

  @override
  AppState reduce() {
    final plannerPageState = state.plannerPageState;
    final selectedDay = plannerPageState.selectedDay;
    final selectedMonth = plannerPageState.selectedMonth;
    final selectedYear = plannerPageState.selectedYear;
    final initialDate = DateTime(selectedYear, selectedMonth, selectedDay).toDateFormatted;

    return state.copyWith.createTaskState(date: initialDate, startTime: null, endTime: null);
  }
}

class DisposeCreateTaskFormAction extends ReduxAction<AppState> {
  DisposeCreateTaskFormAction();

  @override
  AppState reduce() => state.copyWith.createTaskState(
        startTime: null,
        endTime: null,
        date: null,
        title: null,
        notes: null,
      );
}

///
class OnChangeDateAction extends ReduxAction<AppState> {
  OnChangeDateAction(this.pickedDate);

  final DateTime pickedDate;

  @override
  AppState reduce() {
    final datePicked = pickedDate.toDateFormatted;
    return state.copyWith.createTaskState(date: datePicked);
  }
}

///
class OnChangeTimeAction extends ReduxAction<AppState> {
  OnChangeTimeAction({
    required this.type,
    required this.pickedTime,
  });

  final TimeRange type;
  final DateTime pickedTime;

  @override
  AppState reduce() {
    final timePicked = pickedTime.toTimeFormatted;

    if (type == TimeRange.START_TIME) {
      return state.copyWith.createTaskState(startTime: timePicked);
    }
    return state.copyWith.createTaskState(endTime: timePicked);
  }
}

///
class OnChangeTitleAction extends ReduxAction<AppState> {
  OnChangeTitleAction(this.title);

  final String? title;

  @override
  AppState reduce() => state.copyWith.createTaskState(title: title);
}

///
class OnChangeNotesAction extends ReduxAction<AppState> {
  OnChangeNotesAction(this.notes);

  final String? notes;

  @override
  AppState reduce() => state.copyWith.createTaskState(notes: notes);
}

///
class SelectTaskAction extends ReduxAction<AppState> {
  SelectTaskAction(this.index);

  final int index;

  @override
  AppState reduce() {
    final tasks = state.plannerPageState.tasks;

    if (tasks == null) return state;

    return state.copyWith.plannerPageState(selectedTask: tasks[index]);
  }
}

///
class ProgressChangeAction extends LoadingAction {
  ProgressChangeAction(this.progress) : super(actionKey: key);

  static const key = 'progress-change-action';

  final TaskProgress progress;

  @override
  void before() {
    // Update list locally in state first
    dispatch(OnProgressChangeAction(progress));
    super.before();
  }

  @override
  Future<AppState> reduce() async {
    final uid = state.userState.user.uid;
    if (uid == null) return state;

    final tasks = state.plannerPageState.tasks;

    if (tasks == null) return state;

    final dayPlanId =
        '${uid}_${state.plannerPageState.selectedYear}-${state.plannerPageState.selectedMonth.toString().padLeft(2, '0')}-${state.plannerPageState.selectedDay.toString().padLeft(2, '0')}';

    // write in [Firestore]
    await getIt<PlannerService>().updateProgress(
      dayPlanId,
      tasks,
    );
    return state;
  }
}

class OnProgressChangeAction extends ReduxAction<AppState> {
  OnProgressChangeAction(this.progress);

  final TaskProgress progress;

  @override
  AppState reduce() {
    final selectedTaskIndex = state.plannerPageState.selectedTask?.id;

    if (selectedTaskIndex == null) return state;

    final updatedTask = state.plannerPageState.selectedTask?.copyWith(progress: progress.index);

    if (updatedTask == null) return state;

    final tasks = state.plannerPageState.tasks;

    if (tasks == null) return state;

    final updatedTasks = tasks.map((task) => task.id == selectedTaskIndex ? updatedTask : task).toList();

    return state.copyWith.plannerPageState(tasks: updatedTasks, selectedTask: updatedTask);
  }
}
