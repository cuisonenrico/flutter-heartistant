import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/profile/profile.dart';
import 'package:flutter_heartistant/features/profile/profile_vm.dart';
import 'package:flutter_heartistant/state/app_state.dart';

class ProfileConnector extends StatelessWidget {
  const ProfileConnector({super.key});

  static const route = '/profile';
  static const routeName = 'profile';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileVm>(
      vm: () => ProfileVmFactory(),
      builder: (_, vm) => Profile(
        onLogOut: vm.onLogOut,
        userDto: vm.userDto,
      ),
    );
  }
}
