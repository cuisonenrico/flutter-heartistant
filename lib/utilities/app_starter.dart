import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/authentication_app.dart';
import 'package:flutter_authentication/firebase_options.dart';
import 'package:flutter_authentication/state/actions/user_actions.dart';
import 'package:flutter_authentication/state/app_state.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> startApp() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final store = Store<AppState>(
        initialState: AppState.init(),
        actionObservers: [if (kDebugMode) Log.printer(formatter: Log.multiLineFormatter)],
      );

      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user != null) {
          await store.dispatch(UserLoginAction(user));
        }
      });

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
