import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/sign_up/sign_up_connector.dart';
import 'package:flutter_heartistant/state/actions/sign_up_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';

class SignUpVmFactory extends VmFactory<AppState, SignUpConnector, SignUpVm> {
  @override
  fromStore() => SignUpVm(
        onChangeEmail: _onChangeEmail,
        onChangeUsername: _onChangeUsername,
        onChangePassword: _onChangePassword,
        onChangeConfirmPassword: _onChangeConfirmPassword,
        onDisposeSignupForm: _onDisposeSignupForm,
        onSignUpWithEmailAndPassword: _onSignUpWithEmailAndPassword,
      );

  void _onChangeEmail(String? email) => dispatch(SetEmailAction(email));
  void _onChangeUsername(String? username) => dispatch(SetUsernameAction(username));
  void _onChangePassword(String? password) => dispatch(SetPasswordAction(password));
  void _onChangeConfirmPassword(String? confirmPassword) => dispatch(SetConfirmPasswordAction(confirmPassword));

  void _onDisposeSignupForm() => dispatch(DisposeSignUpFormAction());
  void _onSignUpWithEmailAndPassword() => dispatch(SignUpWithEmailAndPasswordAction());
}

class SignUpVm extends Vm {
  SignUpVm({
    required this.onChangeEmail,
    required this.onChangeUsername,
    required this.onChangePassword,
    required this.onChangeConfirmPassword,
    required this.onDisposeSignupForm,
    required this.onSignUpWithEmailAndPassword,
    this.passwordMismatchEvt,
  }) : super(equals: [passwordMismatchEvt]);

  final ValueChanged<String?> onChangeEmail;
  final ValueChanged<String?> onChangeUsername;
  final ValueChanged<String?> onChangePassword;
  final ValueChanged<String?> onChangeConfirmPassword;
  final VoidCallback onDisposeSignupForm;
  final VoidCallback onSignUpWithEmailAndPassword;

  // Events
  final Event<bool>? passwordMismatchEvt;
}
