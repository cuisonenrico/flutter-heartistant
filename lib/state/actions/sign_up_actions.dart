import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_heartistant/state/actions/event_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/utilities/enums/sign_up_enums.dart';
import 'package:flutter_heartistant/utilities/extensions/signup_form_ext.dart';
import 'package:flutter_heartistant/utilities/login/authentication_handler_impl.dart';

/// Disposes [SignUpFormState]
class DisposeSignUpFormAction extends ReduxAction<AppState> {
  DisposeSignUpFormAction();
  @override
  AppState reduce() => state.copyWith.signUpFormState(
        firstName: null,
        lastName: null,
        email: null,
        password: null,
        confirmPassword: null,
        agreeToTerms: false,
      );
}

/// Sets [agreeToTerms] in [SignUpFormState]
class SetAgreeToTermsAction extends ReduxAction<AppState> {
  SetAgreeToTermsAction(this.didAgree);

  final bool didAgree;
  @override
  AppState reduce() => state.copyWith.signUpFormState(agreeToTerms: !state.signUpFormState.agreeToTerms);
}

/// Sets [firstName] in [SignUpFormState]
class SetFirstNameAction extends ReduxAction<AppState> {
  SetFirstNameAction(this.firstname);

  final String? firstname;

  @override
  AppState reduce() => state.copyWith.signUpFormState(firstName: firstname);
}

/// Sets [lastName] in [SignUpFormState]
class SetLastNameAction extends ReduxAction<AppState> {
  SetLastNameAction(this.lastname);

  final String? lastname;

  @override
  AppState reduce() => state.copyWith.signUpFormState(lastName: lastname);
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

class DisposeInputErrorListAction extends ReduxAction<AppState> {
  @override
  AppState reduce() => state.copyWith(inputErrorList: []);
}

/// Sets the list of input errors in state
class SetInputErrorListAction extends ReduxAction<AppState> {
  SetInputErrorListAction();

  @override
  AppState? reduce() {
    final signUpFormState = state.signUpFormState;

    final firstName = signUpFormState.firstName;
    final lastName = signUpFormState.lastName;
    final email = signUpFormState.email;
    final password = signUpFormState.password;
    final confirmPassword = signUpFormState.confirmPassword;
    final agreeToTerms = signUpFormState.agreeToTerms;

    // TODO: add necessary validations
    final list = [
      firstName.isNullOrBlank ? SignUpErrorCodes.FIRST_NAME : null,
      lastName.isNullOrBlank ? SignUpErrorCodes.LAST_NAME : null,
      email.isNullOrBlank ? SignUpErrorCodes.EMAIL : null,
      password.isNullOrBlank ? SignUpErrorCodes.PASSWORD : null,
      confirmPassword.isNullOrBlank ? SignUpErrorCodes.CONFIRM_PASSWORD : null,
      agreeToTerms == false ? SignUpErrorCodes.TERMS : null,
    ].mapNotNull((code) => code).toList();

    return state.copyWith(inputErrorList: list);
  }
}

/// Registers user using email and password
class SignUpWithEmailAndPasswordAction extends ReduxAction<AppState> {
  bool didSucceed = false;
  @override
  Future<AppState?> reduce() async {
    final authHndlr = AuthenticationHandlerImpl();
    final signUpFormState = state.signUpFormState;
    final email = signUpFormState.email;
    final password = signUpFormState.password;
    final confirmPassword = signUpFormState.confirmPassword;

    // TODO: add validations i.e. email format, password length, ticked agree to terms of service
    dispatch(SetInputErrorListAction());
    if (password != confirmPassword) {
      // Set an event notifying a mismatch between password and confirm password
      dispatch(SetPasswordMismatchEvent());

      // then stops the action from proceeding any further
      return state;
    }

    if (email.isNullOrBlank || password.isNullOrBlank || confirmPassword.isNullOrBlank) return null;

    final userDto = await authHndlr.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
      confirmPassword: confirmPassword!,
      displayName: signUpFormState.fullName,
    );

    didSucceed = userDto != null;

    return state.copyWith.userState.user(
      uid: userDto?.uid,
      email: userDto?.email,
      displayName: userDto?.displayName,
    );
  }

  @override
  void after() {
    // If register is successful
    // TODO: reevaluate behavior
    dispatch(SetLoginSuccessEvt(didSucceed));
    // dispatch(DisposeSignUpFormAction());
    super.after();
  }
}
