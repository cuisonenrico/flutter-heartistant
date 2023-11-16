import 'package:flutter/cupertino.dart';
import 'package:flutter_heartistant/features/login/login_screen_connector.dart';
import 'package:flutter_heartistant/features/widgets/primary_button.dart';
import 'package:flutter_heartistant/utilities/colors.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({
    required this.onLogOut,
    super.key,
  });
  final VoidCallback onLogOut;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
