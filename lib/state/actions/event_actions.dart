import 'package:async_redux/async_redux.dart';
import 'package:flutter_authentication/state/actions/user_actions.dart';
import 'package:flutter_authentication/state/app_state.dart';

class SetLoginSuccessEvt extends ReduxAction<AppState> {
  SetLoginSuccessEvt(this.didSucceed);

  final bool didSucceed;
  @override
  AppState reduce() => state.copyWith(loginSuccessEvt: Event(didSucceed));

  @override
  void after() {
    dispatch(SetUserLoggedInStatus(true));
    super.after();
  }
}

class SetPasswordMismatchEvent extends ReduxAction<AppState> {
  SetPasswordMismatchEvent();

  @override
  AppState reduce() => state.copyWith(passwordMismatchEvt: Event(true));
}
