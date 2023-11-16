import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/features/sign_up/sign_up.dart';
import 'package:flutter_heartistant/features/sign_up/sign_up_vm.dart';
import 'package:flutter_heartistant/state/app_state.dart';

class SignUpConnector extends StatelessWidget {
  const SignUpConnector({super.key});

  static const route = 'sign-up-page';
  static const routeName = 'sign-up-page';

  void _consumeEvents(SignUpVm vm) {
    if (vm.passwordMismatchEvt?.isNotSpent == true) {
      vm.passwordMismatchEvt?.consume();
      // TODO: do something when [password] and [confirmPassword] is mismatched
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SignUpVm>(
      onDidChange: (_, __, vm) => _consumeEvents(vm),
      vm: () => SignUpVmFactory(),
      builder: (_, vm) => SignUpScreen(
        onChangeFirstName: vm.onChangeFirstName,
        onChangeLastName: vm.onChangeLastName,
        onChangeEmail: vm.onChangeEmail,
        onChangePassword: vm.onChangePassword,
        onChangeConfirmPassword: vm.onChangeConfirmPassword,
        onChangeAgreeToTerms: vm.onChangeAgreeToTerms,
        onDisposeSignupForm: vm.onDisposeSignupForm,
        onSignUpWithEmailAndPassword: vm.onSignUpWithEmailAndPassword,
        agreeToTerms: vm.agreeToTerms,
        inputErrorList: vm.inputErrorList,
      ),
    );
  }
}
