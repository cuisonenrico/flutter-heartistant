import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_task_state.freezed.dart';
part 'create_task_state.g.dart';

@freezed
class CreateTaskState with _$CreateTaskState {
  const factory CreateTaskState({
    String? date,
    String? time,
    String? title,
    String? notes,
  }) = _CreateTaskState;

  factory CreateTaskState.fromJson(Map<String, dynamic> json) => _$CreateTaskStateFromJson(json);

  factory CreateTaskState.init() => const CreateTaskState();
}
