import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/one/one.dart';
import 'package:flutter_heartistant/features/profile/profile.dart';
import 'package:flutter_heartistant/features/three/three.dart';
import 'package:flutter_heartistant/features/two/two.dart';
import 'package:flutter_heartistant/features/widgets/app_bar.dart';
import 'package:flutter_heartistant/features/widgets/app_scaffold.dart';
import 'package:flutter_heartistant/features/widgets/bottom_nav.dart';
import 'package:flutter_heartistant/utilities/enums/page_view_enum.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    required this.onLogOut,
    required this.onChangePageViewIndex,
    required this.pageViewIndex,
    super.key,
  });

  final VoidCallback onLogOut;
  final ValueChanged<int> onChangePageViewIndex;

  final int pageViewIndex;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: MyAppBar(
          isBackButtonVisible: false,
          onSecondaryActionPressed: () {},
          label: PageViewList.values[pageViewIndex].title,
          isSecondaryIconVisible: true,
        ),
        bottomNavigationBar: BottomNavBar(
          pageViewIndex: pageViewIndex,
          onChangePageViewIndex: onChangePageViewIndex,
        ),
        body: PageView(
          onPageChanged: (index) {},
          children: [
            if (pageViewIndex == 0) const One(),
            if (pageViewIndex == 1) const Two(),
            if (pageViewIndex == 2) const Three(),
            if (pageViewIndex == 3) Profile(onLogOut: onLogOut),
          ],
        ));
  }
}
