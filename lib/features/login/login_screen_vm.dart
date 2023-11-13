import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/login/login_screen_connector.dart';
import 'package:flutter_authentication/state/actions/login_actions.dart';
import 'package:flutter_authentication/state/app_state.dart';
import 'package:flutter_authentication/state/forms/login_form_state.dart';

class LoginScreenVmFactory extends VmFactory<AppState, LoginScreenConnector, LoginScreenVm> {
  @override
  fromStore() => LoginScreenVm(
        onChangeId: _onChangeId,
        onChangePassword: _onChangePassword,
        onSetLoginErrorMessage: _onSetLoginErrorMessage,
        onLogin: _onLogin,
        onLoginWithGoogle: _onLoginWithGoogle,
        onLoginWithFacebook: _onLoginWithFacebook,
        onDisposeCredentials: _onDisposeCredentials,
        loginErrorMessage: _loginErrorMessage,
        loginSuccessEvt: _loginSuccessEvt,
      );

  Future<void> _onLogin() async => await dispatch(LoginUserAction());
  Future<void> _onLoginWithGoogle() async => await dispatch(LoginWithGoogleAction());
  Future<void> _onLoginWithFacebook() async => await dispatch(LoginWithFacebookAction());

  void _onChangeId(String identifier) => dispatch(SetIdentifierAction(identifier));

  void _onChangePassword(String password) => dispatch(SetPasswordAction(password));

  void _onSetLoginErrorMessage(String loginErrorMessage) => dispatch(SetLoginErrorMessageAction(loginErrorMessage));

  void _onDisposeCredentials() => dispatch(DisposeCredentialsAction());

  LoginFormState get _loginFormState => state.loginFormState;

  String? get _loginErrorMessage => _loginFormState.errorMessage;

  Event<bool>? get _loginSuccessEvt => state.loginSuccessEvt;
}

class LoginScreenVm extends Vm {
  LoginScreenVm({
    required this.onChangeId,
    required this.onChangePassword,
    required this.onSetLoginErrorMessage,
    required this.onLogin,
    required this.onLoginWithGoogle,
    required this.onLoginWithFacebook,
    required this.onDisposeCredentials,
    this.loginErrorMessage,
    this.loginSuccessEvt,
  }) : super(equals: [
          loginErrorMessage,
          loginSuccessEvt,
        ]);

  final String? loginErrorMessage;

  final ValueChanged<String> onChangeId;
  final ValueChanged<String> onChangePassword;
  final ValueChanged<String> onSetLoginErrorMessage;
  final VoidCallback onLogin;
  final VoidCallback onLoginWithGoogle;
  final VoidCallback onLoginWithFacebook;
  final VoidCallback onDisposeCredentials;

  // Events
  final Event<bool>? loginSuccessEvt;
}
