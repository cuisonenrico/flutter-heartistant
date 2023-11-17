import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/utilities/handlers/users_handler.dart';

/// Sets [isLoggedIn] status in state
class SetUserLoggedInStatus extends ReduxAction<AppState> {
  SetUserLoggedInStatus(this.isLoggedIn);

  final bool isLoggedIn;

  @override
  AppState reduce() => state.copyWith.userState(isLoggedIn: isLoggedIn);
}

/// Sets the logged in [userState]
class UserLoginAction extends ReduxAction<AppState> {
  UserLoginAction(this.user);

  final User user;

  @override
  Future<AppState> reduce() async {
    final userDto = await UsersHandler().userLogin(user);

    if (userDto == null) return state;

    return state.copyWith.userState(user: userDto);
  }

  @override
  void after() {
    // TODO: optimize this
    dispatch(SetUserLoggedInStatus(true));
    super.after();
  }
}
