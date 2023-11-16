import 'package:async_redux/async_redux.dart';
import 'package:flutter_heartistant/state/actions/event_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/utilities/extensions/string_ext.dart';
import 'package:flutter_heartistant/utilities/login/authentication_handler_impl.dart';

/// Disposes [SignUpFormState]
class DisposeSignUpFormAction extends ReduxAction<AppState> {
  DisposeSignUpFormAction();
  @override
  AppState reduce() => state.copyWith.signUpFormState(
        username: null,
        password: null,
        email: null,
        confirmPassword: null,
      );
}

/// Sets [username] in [SignUpFormState]
class SetUsernameAction extends ReduxAction<AppState> {
  SetUsernameAction(this.username);

  final String? username;

  @override
  AppState reduce() => state.copyWith.signUpFormState(username: username);
}

/// Sets [password] in [SignUpFormState]
class SetPasswordAction extends ReduxAction<AppState> {
  SetPasswordAction(this.password);

  final String? password;

  @override
  AppState reduce() => state.copyWith.signUpFormState(password: password);
}

/// Sets [confirmPassword] in [SignUpFormState]
class SetConfirmPasswordAction extends ReduxAction<AppState> {
  SetConfirmPasswordAction(this.confirmPassword);

  final String? confirmPassword;

  @override
  AppState reduce() => state.copyWith.signUpFormState(confirmPassword: confirmPassword);
}

/// Sets [email] in [SignUpFormState]
class SetEmailAction extends ReduxAction<AppState> {
  SetEmailAction(this.email);

  final String? email;

  @override
  AppState reduce() => state.copyWith.signUpFormState(email: email);
}

/// Registers user using email and password
class SignUpWithEmailAndPasswordAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    final authHndlr = AuthenticationHandlerImpl();
    final signUpFormState = state.signUpFormState;
    final email = signUpFormState.email;
    final password = signUpFormState.password;
    final confirmPassword = signUpFormState.confirmPassword;

    if (password != confirmPassword) {
      // Set an event notifying a mismatch between password and confirm password
      dispatch(SetPasswordMismatchEvent());

      // then stops the action from proceeding any further
      return state;
    }

    if (email.isNullOrBlank || password.isNullOrBlank || confirmPassword.isNullOrBlank) return state;

    authHndlr.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
      confirmPassword: confirmPassword!,
    );

    return state;
  }

  @override
  void after() {
    // If register is successful
    dispatch(DisposeSignUpFormAction());
    super.after();
  }
}
