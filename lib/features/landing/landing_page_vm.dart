import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/landing/landing_page_connector.dart';
import 'package:flutter_heartistant/state/actions/login_actions.dart';
import 'package:flutter_heartistant/state/actions/main_page_action.dart';
import 'package:flutter_heartistant/state/actions/user_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';

class LandingPageVmFactory extends VmFactory<AppState, LandingPageConnector, LandingPageVm> {
  @override
  fromStore() => LandingPageVm(
        onLogOut: _onLogOut,
        onChangePageViewIndex: _onChangePageViewIndex,
        pageViewIndex: _pageViewIndex,
      );

  int get _pageViewIndex => state.mainPageState.pageViewIndex;

  void _onChangePageViewIndex(int index) => dispatch(SetPageViewIndexAction(index));

  void _onLogOut() {
    dispatch(SignOutUserAction());
    dispatch(SetUserLoggedInStatus(false));
  }
}

class LandingPageVm extends Vm {
  LandingPageVm({
    required this.onLogOut,
    required this.onChangePageViewIndex,
    required this.pageViewIndex,
  }) : super(equals: [pageViewIndex]);

  final VoidCallback onLogOut;
  final ValueChanged<int> onChangePageViewIndex;

  final int pageViewIndex;
}
