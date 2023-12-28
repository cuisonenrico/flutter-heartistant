import 'package:async_redux/async_redux.dart';
import 'package:flutter_heartistant/state/app_state.dart';

abstract class LoadingAction extends ReduxAction<AppState> {
  LoadingAction({this.actionKey});
  final String? actionKey;
  @override
  void before() => dispatch(WaitAction.add(actionKey));

  @override
  void after() => dispatch(WaitAction.remove(actionKey));
}
