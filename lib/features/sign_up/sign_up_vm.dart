import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/sign_up/sign_up_connector.dart';
import 'package:flutter_heartistant/state/actions/sign_up_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/utilities/enums/sign_up_enums.dart';

class SignUpVmFactory extends VmFactory<AppState, SignUpConnector, SignUpVm> {
  @override
  fromStore() => SignUpVm(
        onChangeFirstName: _onChangeFirstName,
        onChangeLastName: _onChangeLastName,
        onChangeEmail: _onChangeEmail,
        onChangePassword: _onChangePassword,
        onChangeConfirmPassword: _onChangeConfirmPassword,
        onChangeAgreeToTerms: _onChangeAgreeToTerms,
        onDisposeSignupForm: _onDisposeSignupForm,
        onSignUpWithEmailAndPassword: _onSignUpWithEmailAndPassword,
        agreeToTerms: state.signUpFormState.agreeToTerms,
        passwordMismatchEvt: state.passwordMismatchEvt,
        inputErrorList: state.inputErrorList,
      );

  void _onChangeFirstName(String? firstname) => dispatch(SetFirstNameAction(firstname));
  void _onChangeLastName(String? lastname) => dispatch(SetLastNameAction(lastname));
  void _onChangeEmail(String? email) => dispatch(SetEmailAction(email));
  void _onChangePassword(String? password) => dispatch(SetPasswordAction(password));
  void _onChangeConfirmPassword(String? confirmPassword) => dispatch(SetConfirmPasswordAction(confirmPassword));
  void _onChangeAgreeToTerms(bool didAgree) => dispatch(SetAgreeToTermsAction(didAgree));

  void _onDisposeSignupForm() {
    dispatch(DisposeSignUpFormAction());
    dispatch(DisposeInputErrorListAction());
  }

  void _onSignUpWithEmailAndPassword() => dispatch(SignUpWithEmailAndPasswordAction());
}

class SignUpVm extends Vm {
  SignUpVm({
    required this.onChangeFirstName,
    required this.onChangeLastName,
    required this.onChangeEmail,
    required this.onChangePassword,
    required this.onChangeConfirmPassword,
    required this.onChangeAgreeToTerms,
    required this.onDisposeSignupForm,
    required this.onSignUpWithEmailAndPassword,
    required this.agreeToTerms,
    required this.inputErrorList,
    this.passwordMismatchEvt,
  }) : super(equals: [
          agreeToTerms,
          passwordMismatchEvt,
          inputErrorList,
        ]);

  final ValueChanged<String?> onChangeFirstName;
  final ValueChanged<String?> onChangeLastName;
  final ValueChanged<String?> onChangeEmail;
  final ValueChanged<String?> onChangePassword;
  final ValueChanged<String?> onChangeConfirmPassword;
  final ValueChanged<bool> onChangeAgreeToTerms;
  final VoidCallback onDisposeSignupForm;
  final VoidCallback onSignUpWithEmailAndPassword;

  final bool agreeToTerms;
  final List<SignUpErrorCodes> inputErrorList;

  // Events
  final Event<bool>? passwordMismatchEvt;
}
