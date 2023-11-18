import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/one/one.dart';
import 'package:flutter_heartistant/features/profile/profile_connector.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/three/three.dart';
import 'package:flutter_heartistant/features/two/two.dart';
import 'package:flutter_heartistant/features/widgets/app_bar.dart';
import 'package:flutter_heartistant/features/widgets/app_scaffold.dart';
import 'package:flutter_heartistant/features/widgets/landing_page_navigation_bar.dart';
import 'package:flutter_heartistant/utilities/enums/page_view_enum.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    required this.onChangePageViewIndex,
    required this.pageViewIndex,
    super.key,
  });

  final ValueChanged<int> onChangePageViewIndex;

  final int pageViewIndex;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: MyAppBar(
          isBackButtonVisible: false,
          onSecondaryActionPressed: () {},
          label: PageViewList.values[pageViewIndex].title,
          labelTextStyle: TextStyles.headline2.copyWith(color: Colors.black),
          isSecondaryIconVisible: true,
          secondaryActionIcon: Icons.notifications,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.07,
              child: PageView(
                children: [
                  if (pageViewIndex == 0) const One(),
                  if (pageViewIndex == 1) const Two(),
                  if (pageViewIndex == 2) const Three(),
                  if (pageViewIndex == 3) const ProfileConnector(),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: LandingPageNavigationBar(
                pageViewIndex: pageViewIndex,
                onChangePageViewIndex: onChangePageViewIndex,
              ),
            ),
          ],
        ));
  }
}
