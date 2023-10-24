import 'package:async_redux/async_redux.dart';
import 'package:flutter_authentication/state/app_state.dart';

class SetUserLoggedInStatus extends ReduxAction<AppState> {
  SetUserLoggedInStatus(this.isLoggedIn);

  final bool isLoggedIn;

  @override
  AppState reduce() => state.copyWith.userState(isLoggedIn: isLoggedIn);
}
