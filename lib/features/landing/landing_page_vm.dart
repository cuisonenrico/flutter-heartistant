import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/landing/landing_page_connector.dart';
import 'package:flutter_authentication/state/actions/login_actions.dart';
import 'package:flutter_authentication/state/actions/user_actions.dart';
import 'package:flutter_authentication/state/app_state.dart';

class LandingPageVmFactory extends VmFactory<AppState, LandingPageConnector, LandingPageVm> {
  @override
  fromStore() => LandingPageVm(onLogOut: _onLogOut);

  void _onLogOut() {
    dispatch(SignOutUserAction());
    dispatch(SetUserLoggedInStatus(false));
  }
}

class LandingPageVm extends Vm {
  LandingPageVm({
    required this.onLogOut,
  }) : super(equals: []);

  final VoidCallback onLogOut;
}
