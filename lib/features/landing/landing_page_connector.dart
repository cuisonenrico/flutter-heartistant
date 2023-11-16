import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/features/landing/landing_page.dart';
import 'package:flutter_heartistant/features/landing/landing_page_vm.dart';
import 'package:flutter_heartistant/state/app_state.dart';

class LandingPageConnector extends StatelessWidget {
  const LandingPageConnector({super.key});

  static const route = '/landing-page';
  static const routeName = 'landing-page';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LandingPageVm>(
      vm: () => LandingPageVmFactory(),
      builder: (_, vm) => LandingPage(
        onLogOut: vm.onLogOut,
        pageViewIndex: vm.pageViewIndex,
        onChangePageViewIndex: vm.onChangePageViewIndex,
      ),
    );
  }
}
