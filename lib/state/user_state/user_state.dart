import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';
part 'user_state.g.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default(false) bool isLoggedIn,
    @Default(UserDto()) UserDto user,
  }) = _UserState;

  factory UserState.fromJson(Map<String, dynamic> json) => _$UserStateFromJson(json);

  factory UserState.init() => const UserState();
}
