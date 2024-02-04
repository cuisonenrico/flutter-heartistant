import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_page_state.freezed.dart';
part 'main_page_state.g.dart';

@freezed
class MainPageState with _$MainPageState {
  const factory MainPageState({
    @Default(0) int pageViewIndex,
    @Default(false) bool isCreatingTask,
  }) = _MainPageState;

  factory MainPageState.fromJson(Map<String, dynamic> json) => _$MainPageStateFromJson(json);

  factory MainPageState.init() => const MainPageState();
}
