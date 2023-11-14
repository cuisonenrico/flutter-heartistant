import 'package:async_redux/async_redux.dart';
import 'package:flutter_authentication/state/forms/login_form_state.dart';
import 'package:flutter_authentication/state/forms/sign_up_form_state.dart';
import 'package:flutter_authentication/state/main_page_state/main_page_state.dart';
import 'package:flutter_authentication/state/user_state/user_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
class AppState with _$AppState {
  factory AppState({
    // Sub-states
    @Default(LoginFormState()) LoginFormState loginFormState,
    @Default(SignUpFormState()) SignUpFormState signUpFormState,
    @Default(UserState()) UserState userState,
    @Default(MainPageState()) MainPageState mainPageState,

    // Events
    @JsonKey(includeFromJson: false) Event<String>? errorStringEvt,
    @JsonKey(includeFromJson: false) Event<bool>? loginSuccessEvt,
    @JsonKey(includeFromJson: false) Event<bool>? passwordMismatchEvt,
  }) = _AppState;

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
