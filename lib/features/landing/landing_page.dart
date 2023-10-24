import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/login/login_screen_connector.dart';
import 'package:flutter_authentication/features/widgets/app_bar.dart';
import 'package:flutter_authentication/features/widgets/app_scaffold.dart';
import 'package:flutter_authentication/features/widgets/primary_button.dart';
import 'package:flutter_authentication/utilities/colors.dart';
import 'package:flutter_authentication/utilities/widget_constants.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    required this.onLogOut,
    super.key,
  });

  final VoidCallback onLogOut;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MyAppBar(
        isBackButtonVisible: false,
        onSecondaryActionPressed: () {},
        label: 'Landing Page',
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultHalfPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PrimaryButton(
              onPressed: () {
                onLogOut();
                context.pushReplacementNamed(LoginScreenConnector.routeName);
              },
              label: 'Logout',
              color: mediumGrey,
            ),
          ],
        ),
      ),
    );
  }
}
