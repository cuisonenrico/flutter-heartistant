import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
class AppState with _$AppState {
  factory AppState() = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

  factory AppState.init() => AppState();
}

abstract class StateSerializer<St> {
  Map<String, dynamic> encode(St state);

  St decode(Map<String, dynamic> data);
}

class AppStateSerializer extends StateSerializer<AppState> {
  @override
  AppState decode(Map<String, dynamic> data) => AppState.fromJson(data);

  @override
  Map<String, dynamic> encode(AppState state) => state.toJson();
}
