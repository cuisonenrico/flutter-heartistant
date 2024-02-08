import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_dto.freezed.dart';
part 'task_dto.g.dart';

@freezed
class TaskDto with _$TaskDto {
  const factory TaskDto({
    int? id,
    String? note,
    String? title,
    String? time,
    int? progress,
  }) = _TaskDto;

  factory TaskDto.fromJson(Map<String, dynamic> json) => _$TaskDtoFromJson(json);

  factory TaskDto.init() => const TaskDto();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "note": note,
        "title": title,
        "time": time,
        "progress": progress,
      };
}
