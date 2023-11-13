import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/features/landing/landing_page_connector.dart';
import 'package:flutter_authentication/features/login/login_screen_connector.dart';
import 'package:flutter_authentication/features/sign_up/sign_up_connector.dart';
import 'package:flutter_authentication/state/app_state.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');

final router = GoRouter(
  observers: [routeObservers],
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  redirect: (context, routeState) async {
    final state = StoreProvider.state<AppState>(context);
    final isLoggedIn = state?.userState.isLoggedIn == true;

    if (routeState.uri.toString().contains('sign-up-page')) return null;

    if (!isLoggedIn) return LoginScreenConnector.route;

    return routeState.uri.toString() == '/' ? LandingPageConnector.route : routeState.uri.toString();
  },
  routes: [
    /// Landing Page
    ///   -
    GoRoute(
      path: LandingPageConnector.route,
      name: LandingPageConnector.routeName,
      builder: (_, __) => const LandingPageConnector(),
      routes: const [],
    ),

    /// Login Screen
    ///   - Sign Up
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
        ]),
  ],
);

// Register the RouteObserver as a navigation observer.
final RouteObserver<ModalRoute<void>> routeObservers = RouteObserver<ModalRoute<void>>();
