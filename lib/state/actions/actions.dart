import 'package:async_redux/async_redux.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:flutter_heartistant/utilities/enums/page_view_enum.dart';

abstract class LoadingAction extends ReduxAction<AppState> {
  LoadingAction({this.actionKey});
  final String? actionKey;
  @override
  void before() => dispatch(WaitAction.add(actionKey));

  @override
  void after() => dispatch(WaitAction.remove(actionKey));
}

class ChatRoomExistsAction extends ReduxAction<AppState> {
  ChatRoomExistsAction(this.isExisting);

  final String isExisting;
  @override
  AppState reduce() => state.copyWith(chatRoomExistsEvt: Event(isExisting));
}

class SetPageActionButtonEventAction extends ReduxAction<AppState> {
  SetPageActionButtonEventAction();

  @override
  AppState reduce() {
    final pageView = PageViewList.values[state.mainPageState.pageViewIndex];
    return state.copyWith(pageViewActionButtonEvent: Event(pageView));
  }
}
