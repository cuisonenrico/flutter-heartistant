import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/login/login_screen_connector.dart';
import 'package:flutter_authentication/features/sign_up/sign_up_connector.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');

final router = GoRouter(
  observers: [routeObservers],
  initialLocation: LoginScreenConnector.route,
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: LoginScreenConnector.route,
      name: LoginScreenConnector.routeName,
      builder: (_, __) => const LoginScreenConnector(),
      routes: [
        GoRoute(
          path: SignUpConnector.route,
          name: SignUpConnector.routeName,
          builder: (_, __) => const SignUpConnector(),
        ),
      ],
    ),
  ],
);

// Register the RouteObserver as a navigation observer.
final RouteObserver<ModalRoute<void>> routeObservers = RouteObserver<ModalRoute<void>>();
