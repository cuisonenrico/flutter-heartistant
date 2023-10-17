import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/authentication_app.dart';
import 'package:flutter_authentication/state/app_state.dart';

Future<void> startApp() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      AppState? state;

      final store = Store<AppState>(
        initialState: state ?? AppState.init(),
        actionObservers: [if (kDebugMode) Log.printer(formatter: Log.multiLineFormatter)],
      );

      runApp(
        StoreProvider<AppState>(
          store: store,
          child: const AuthenticationApp(),
        ),
      );
    },
    (error, stack) async => {},
  );
}
