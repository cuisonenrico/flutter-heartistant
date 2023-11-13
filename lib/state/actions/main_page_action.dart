import 'package:async_redux/async_redux.dart';
import 'package:flutter_authentication/state/app_state.dart';

class SetPageViewIndexAction extends ReduxAction<AppState> {
  SetPageViewIndexAction(this.index);

  final int index;

  @override
  AppState reduce() => state.copyWith.mainPageState(pageViewIndex: index);
}
