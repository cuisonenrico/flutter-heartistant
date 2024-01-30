import 'package:async_redux/async_redux.dart';

extension WaitExt on Wait {
  bool isWaitingForKeys(List<String> keys) => keys.any((key) => isWaitingFor(key));
}
