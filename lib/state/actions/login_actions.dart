import 'package:async_redux/async_redux.dart';
import 'package:flutter_authentication/state/actions/event_actions.dart';
import 'package:flutter_authentication/state/app_state.dart';
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

/// Try login given the credentials in state then set [loginSuccessEvt]
class LoginUserAction extends ReduxAction<AppState> {
  LoginUserAction();

  @override
  Future<AppState> reduce() async {
    final identifier = state.loginFormState.identifier;
    final password = state.loginFormState.password;

    if (identifier == null || password == null) return state;

    final userCred = await AuthenticationHandlerImpl().signInWithEmailAndPassword(
      email: identifier,
      password: password,
    );

    final isValid = userCred.user != null;

    dispatch(SetLoginSuccessEvt(isValid));

    // Clears credentials stored in state
    dispatch(DisposeCredentialsAction());

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
