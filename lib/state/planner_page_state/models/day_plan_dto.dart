import 'package:flutter_heartistant/state/planner_page_state/models/task_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'day_plan_dto.freezed.dart';
part 'day_plan_dto.g.dart';

@freezed
class DayPlanDto with _$DayPlanDto {
  const factory DayPlanDto({
    String? creationDate,
    List<TaskDto>? tasks,
  }) = _DayPlanDto;

  factory DayPlanDto.fromJson(Map<String, dynamic> json) => _$DayPlanDtoFromJson(json);

  factory DayPlanDto.init() => const DayPlanDto();
}
