import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_authentication/features/landing/landing_page_connector.dart';
import 'package:flutter_authentication/features/login/login_screen.dart';
import 'package:flutter_authentication/features/login/login_screen_vm.dart';
import 'package:flutter_authentication/state/app_state.dart';
import 'package:flutter_authentication/utilities/app_router.dart';

class LoginScreenConnector extends StatelessWidget {
  const LoginScreenConnector({super.key});

  static const route = '/login-page';
  static const routeName = 'login-page';

  void _consumeEvents(LoginScreenVm vm) {
    if (vm.loginSuccessEvt?.isNotSpent == true) {
      final loginSuccess = vm.loginSuccessEvt?.consume();

      if (loginSuccess == true) {
        router.pushNamed(LandingPageConnector.routeName);
      } else {
        vm.onDisposeCredentials();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginScreenVm>(
      onDidChange: (_, __, vm) => _consumeEvents(vm),
      vm: () => LoginScreenVmFactory(),
      builder: (_, vm) => LoginScreen(
        onChangeId: vm.onChangeId,
        onChangePassword: vm.onChangePassword,
        onLogin: vm.onLogin,
        loginErrorMessage: vm.loginErrorMessage,
        onLoginWithGoogle: vm.onLoginWithGoogle,
        onLoginWithFacebook: vm.onLoginWithFacebook,
      ),
    );
  }
}
