import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/login/login_screen_connector.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/widgets/circular_image_container.dart';
import 'package:flutter_heartistant/features/widgets/floating_container.dart';
import 'package:flutter_heartistant/features/widgets/labeled_info.dart';
import 'package:flutter_heartistant/features/widgets/primary_button.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({
    required this.onLogOut,
    required this.userDto,
    super.key,
  });

  final VoidCallback onLogOut;
  final UserDto userDto;

  @override
  Widget build(BuildContext context) {
    const verticalSpaceHalf = VerticalSpace(defaultHalfSpacing);

    return Padding(
      padding: const EdgeInsets.all(defaultHalfPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FloatingContainer(
              padding: const EdgeInsets.all(defaultQuarterPadding),
              child: Row(
                children: [
                  const CircularImageContainer(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/flutter-project-d2944.appspot.com/o/heartistant_logo.png?alt=media&token=deb54aa7-069d-4202-af59-d544095272b7',
                  ),
                  const HorizontalSpace(defaultSpacing),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userDto.displayName ?? emptyString),
                      Text(userDto.email ?? emptyString),
                    ],
                  )
                ],
              ),
            ),
            verticalSpaceHalf,
            FloatingContainer(
              cardTitle: 'Personal Information',
              onPressedSecondary: () {},
              padding: const EdgeInsets.all(defaultHalfPadding),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LabeledInfo(
                    label: 'Complete Name:',
                    info: 'Yoki Kweeson',
                  ),
                  LabeledInfo(
                    label: 'Birth Date:',
                    info: 'February 17, 1999',
                  ),
                  LabeledInfo(
                    label: 'Age:',
                    info: '24 Years Old',
                  ),
                  LabeledInfo(
                    label: 'Gender:',
                    info: 'Male',
                  ),
                  LabeledInfo(
                    label: 'Weight:',
                    info: '80 kg',
                  ),
                  LabeledInfo(
                    label: 'Height:',
                    info: '170.0 cm',
                  ),
                ],
              ),
            ),
            verticalSpaceHalf,
            Center(
              child: PrimaryButton(
                width: 200,
                onPressed: () {
                  onLogOut();
                  context.pushReplacementNamed(LoginScreenConnector.routeName);
                },
                label: 'Logout',
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
