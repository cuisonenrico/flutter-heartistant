import 'package:flutter_heartistant/state/planner_page_state/models/task_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'planner_page_state.freezed.dart';
part 'planner_page_state.g.dart';

@freezed
class PlannerPageState with _$PlannerPageState {
  const factory PlannerPageState({
    @Default(0) int selectedDay,
    @Default(0) int selectedMonth,
    @Default(0) int selectedYear,
    @JsonKey(includeFromJson: false) @Default(<TaskDto>[]) List<TaskDto>? tasks,
  }) = _PlannerPageState;

  factory PlannerPageState.fromJson(Map<String, dynamic> json) => _$PlannerPageStateFromJson(json);

  factory PlannerPageState.init() => PlannerPageState(
        selectedDay: DateTime.now().day,
        selectedMonth: DateTime.now().month,
        selectedYear: DateTime.now().year,
        tasks: List.empty(),
      );
}
