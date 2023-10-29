import 'package:async_redux/async_redux.dart';
import 'package:flutter_authentication/features/sign_up/sign_up_connector.dart';
import 'package:flutter_authentication/state/app_state.dart';

class SignUpVmFactory extends VmFactory<AppState, SignUpConnector, SignUpVm> {
  @override
  fromStore() => SignUpVm();
}

class SignUpVm extends Vm {
  SignUpVm() : super(equals: []);
}
