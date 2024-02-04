import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/landing/landing_page_connector.dart';
import 'package:flutter_heartistant/state/actions/actions.dart';
import 'package:flutter_heartistant/state/actions/main_page_action.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/utilities/enums/page_view_enum.dart';

class LandingPageVmFactory extends VmFactory<AppState, LandingPageConnector, LandingPageVm> {
  @override
  fromStore() => LandingPageVm(
        onTriggerActionButton: _onTriggerActionButton,
        onChangePageViewIndex: _onChangePageViewIndex,
        pageViewIndex: _pageViewIndex,
        pageViewActionButtonEvt: state.pageViewActionButtonEvent,
      );

  int get _pageViewIndex => state.mainPageState.pageViewIndex;

  void _onChangePageViewIndex(int index) => dispatch(SetPageViewIndexAction(index));

  void _onTriggerActionButton() => dispatch(SetPageActionButtonEventAction());
}

class LandingPageVm extends Vm {
  LandingPageVm({
    required this.onTriggerActionButton,
    required this.onChangePageViewIndex,
    required this.pageViewActionButtonEvt,
    required this.pageViewIndex,
  }) : super(equals: [
          pageViewIndex,
          pageViewActionButtonEvt,
        ]);

  final VoidCallback onTriggerActionButton;
  final ValueChanged<int> onChangePageViewIndex;

  final int pageViewIndex;

  final Event<PageViewList>? pageViewActionButtonEvt;
}
