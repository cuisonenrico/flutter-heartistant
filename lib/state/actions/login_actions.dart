import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_authentication/state/actions/event_actions.dart';
import 'package:flutter_authentication/state/actions/user_actions.dart';
import 'package:flutter_authentication/state/app_state.dart';
import 'package:flutter_authentication/utilities/handlers/users_handler.dart';
import 'package:flutter_authentication/utilities/login/authentication_handler_impl.dart';

/// Sets the [identifier] in loginFormState
class SetIdentifierAction extends ReduxAction<AppState> {
  SetIdentifierAction(this.identifier);

  final String identifier;

  @override
  AppState reduce() {
    if (state.loginFormState.errorMessage != null) dispatch(DisposeErrorMessageAction());

    return state.copyWith.loginFormState(identifier: identifier);
  }
}

/// Sets the [password] in loginFormState
class SetPasswordAction extends ReduxAction<AppState> {
  SetPasswordAction(this.password);

  final String password;

  @override
  AppState reduce() {
    if (state.loginFormState.errorMessage != null) dispatch(DisposeErrorMessageAction());

    return state.copyWith.loginFormState(password: password);
  }
}

/// Sets the [loginErrorMessage] in loginFormState
class SetLoginErrorMessageAction extends ReduxAction<AppState> {
  SetLoginErrorMessageAction(this.loginErrorMessage);

  final String loginErrorMessage;

  @override
  AppState reduce() => state.copyWith.loginFormState(errorMessage: loginErrorMessage);
}

/// Attempts to login with [Google] and sets user in state
class LoginWithGoogleAction extends ReduxAction<AppState> {
  LoginWithGoogleAction();

  @override
  Future<AppState> reduce() async {
    final user = await UsersHandler().signInWithGoogle();

    final userEntity = user.user;

    if (userEntity == null) return state;

    dispatch(UserLoginAction(userEntity));

    return state;
  }
}

/// Attempts to login with [Facebook] and sets user in state
class LoginWithFacebookAction extends ReduxAction<AppState> {
  LoginWithFacebookAction();

  @override
  Future<AppState> reduce() async {
    final user = await UsersHandler().signInWithFacebook();
    final userEntity = user?.user;

    if (userEntity == null) return state;

    dispatch(UserLoginAction(userEntity));

    return state;
  }
}

/// Try login given the credentials in state then set [loginSuccessEvt]
class LoginUserAction extends ReduxAction<AppState> {
  LoginUserAction();

  @override
  Future<AppState> reduce() async {
    final identifier = state.loginFormState.identifier;
    final password = state.loginFormState.password;

    if (identifier == null || password == null) return state;

    var isSuccess = true;

    try {
      await AuthenticationHandlerImpl().signInWithEmailAndPassword(
        email: identifier,
        password: password,
      );
    } on FirebaseAuthException catch (_) {
      isSuccess = false;
    }

    dispatch(SetLoginSuccessEvt(isSuccess));

    return state;
  }
}

/// Disposes [identifier, password] in loginFormState
class DisposeCredentialsAction extends ReduxAction<AppState> {
  DisposeCredentialsAction();

  @override
  AppState reduce() => state.copyWith.loginFormState(
        password: null,
        identifier: null,
      );
}

/// Disposes [identifier, password] in loginFormState
class DisposeErrorMessageAction extends ReduxAction<AppState> {
  DisposeErrorMessageAction();

  @override
  AppState reduce() => state.copyWith.loginFormState(errorMessage: null);
}

/// Signs out user from firebase
class SignOutUserAction extends ReduxAction<AppState> {
  SignOutUserAction();

  @override
  AppState reduce() {
    AuthenticationHandlerImpl().signOut();
    return state;
  }
}
