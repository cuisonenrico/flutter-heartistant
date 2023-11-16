import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_heartistant/features/profile/profile_connector.dart';
import 'package:flutter_heartistant/state/actions/login_actions.dart';
import 'package:flutter_heartistant/state/actions/user_actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';

class ProfileVmFactory extends VmFactory<AppState, ProfileConnector, ProfileVm> {
  @override
  fromStore() => ProfileVm(
        onLogOut: _onLogOut,
        userDto: state.userState.user,
      );

  void _onLogOut() {
    dispatch(SignOutUserAction());
    dispatch(SetUserLoggedInStatus(false));
  }
}

class ProfileVm extends Vm {
  ProfileVm({
    required this.onLogOut,
    required this.userDto,
  }) : super(equals: [userDto]);

  final VoidCallback onLogOut;
  final UserDto userDto;
}
