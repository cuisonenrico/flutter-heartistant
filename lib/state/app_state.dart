import 'package:async_redux/async_redux.dart';
import 'package:flutter_heartistant/state/chat_page_state/chat_page_state.dart';
import 'package:flutter_heartistant/state/forms/login_form_state.dart';
import 'package:flutter_heartistant/state/forms/sign_up_form_state.dart';
import 'package:flutter_heartistant/state/main_page_state/main_page_state.dart';
import 'package:flutter_heartistant/state/user_state/user_state.dart';
import 'package:flutter_heartistant/utilities/enums/sign_up_enums.dart';
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
    @Default(ChatPageState()) ChatPageState chatPageState,
    @JsonKey(includeFromJson: false) @Default(<SignUpErrorCodes>[]) List<SignUpErrorCodes> inputErrorList,

    // Events
    @JsonKey(includeFromJson: false) Event<bool>? loginSuccessEvt,
    @JsonKey(includeFromJson: false) Event<bool>? passwordMismatchEvt,

    // Wait
    @Default(Wait.empty) @JsonKey(name: 'wait', includeFromJson: false) Wait wait,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

  factory AppState.init() => AppState(wait: Wait());
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
