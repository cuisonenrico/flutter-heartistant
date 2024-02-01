import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/landing/landing_page.dart';
import 'package:flutter_heartistant/features/landing/landing_page_vm.dart';
import 'package:flutter_heartistant/features/planner/create_plan_page/create_plan_page.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/utilities/enums/page_view_enum.dart';

class LandingPageConnector extends StatelessWidget {
  const LandingPageConnector({super.key});

  static const route = '/landing-page';
  static const routeName = 'landing-page';

  void _consumeEvents(BuildContext context, LandingPageVm vm) {
    if (vm.pageViewActionButtonEvt?.isNotSpent == true) {
      final pageView = vm.pageViewActionButtonEvt?.consume();
      if (pageView == PageViewList.PLANNER) {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: false,
          useSafeArea: true,
          builder: (_) => const CreatePlanPage(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LandingPageVm>(
      onDidChange: (_, __, vm) => _consumeEvents(context, vm),
      vm: () => LandingPageVmFactory(),
      builder: (_, vm) => LandingPage(
        onTriggerActionButton: vm.onTriggerActionButton,
        pageViewIndex: vm.pageViewIndex,
        onChangePageViewIndex: vm.onChangePageViewIndex,
      ),
    );
  }
}
