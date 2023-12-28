import 'dart:async';

import 'package:flutter_heartistant/features/messaging/services/chat_service.dart';
import 'package:flutter_heartistant/state/actions/actions.dart';
import 'package:flutter_heartistant/state/app_state.dart';

/// Gets the users in firestore and store in state
class GetUserListAction extends LoadingAction {
  GetUserListAction() : super(actionKey: key);

  static const key = 'get-users-action';

  @override
  Future<AppState> reduce() async {
    final userList = await ChatService().getUserList();
    return state.copyWith(chatPageState: state.chatPageState.copyWith(userList: userList));
  }
}
