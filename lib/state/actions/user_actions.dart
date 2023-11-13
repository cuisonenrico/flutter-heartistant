import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_authentication/state/app_state.dart';
import 'package:flutter_authentication/utilities/handlers/users_handler.dart';

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

  User user;
  @override
  Future<AppState> reduce() async {
    final userDto = await UsersHandler().userLogin(user);

    return state.copyWith.userState(user: userDto);
  }

  @override
  void after() {
    SetUserLoggedInStatus(true);
    super.after();
  }
}
