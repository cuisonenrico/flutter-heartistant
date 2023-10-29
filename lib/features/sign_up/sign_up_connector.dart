import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_authentication/features/sign_up/sign_up.dart';
import 'package:flutter_authentication/features/sign_up/sign_up_vm.dart';
import 'package:flutter_authentication/state/app_state.dart';

class SignUpConnector extends StatelessWidget {
  const SignUpConnector({super.key});

  static const route = 'sign-up-page';
  static const routeName = 'sign-up-page';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SignUpVm>(
      vm: () => SignUpVmFactory(),
      builder: (_, vm) => const SignUpScreen(),
    );
  }
}
