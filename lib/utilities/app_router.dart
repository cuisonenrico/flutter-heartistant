import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/login/login_screen_connector.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');

final router = GoRouter(
  observers: [routeObservers],
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  redirect: (context, routeState) {
    return LoginScreenConnector.route;
  },
  routes: [
    GoRoute(
      path: LoginScreenConnector.route,
      name: LoginScreenConnector.routeName,
      builder: (_, __) => const LoginScreenConnector(),
      routes: const [],
    ),
  ],
);

// Register the RouteObserver as a navigation observer.
final RouteObserver<ModalRoute<void>> routeObservers = RouteObserver<ModalRoute<void>>();
