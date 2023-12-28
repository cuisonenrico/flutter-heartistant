// ignore_for_file: strict_raw_type

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/landing/landing_page_connector.dart';
import 'package:flutter_heartistant/features/login/login_screen_connector.dart';
import 'package:flutter_heartistant/features/messaging/chat_page_connector.dart';
import 'package:flutter_heartistant/features/messaging/chat_room/chat_room.dart';
import 'package:flutter_heartistant/features/sign_up/sign_up_connector.dart';
import 'package:flutter_heartistant/state/app_state.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');

final router = GoRouter(
  observers: [routeObservers],
  initialLocation: LandingPageConnector.route,
  navigatorKey: rootNavigatorKey,
  redirect: (context, routeState) async {
    final state = StoreProvider.state<AppState>(context);
    final isLoggedIn = state?.userState.isLoggedIn == true;

    if (routeState.uri.toString().contains('sign-up-page')) return null;

    if (!isLoggedIn) return LoginScreenConnector.route;

    if (routeState.uri.toString() == LandingPageConnector.route) return null;

    return routeState.uri.toString();
  },
  routes: [
    /// Landing Page
    ///   -
    GoRoute(
      path: LandingPageConnector.route,
      name: LandingPageConnector.routeName,
      builder: (_, __) => const LandingPageConnector(),
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const LandingPageConnector(),
      ),
      routes: [
        GoRoute(
          path: ChatPageConnector.route,
          name: ChatPageConnector.routeName,
          builder: (_, __) => const ChatPageConnector(),
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const ChatPageConnector(),
          ),
          routes: [
            GoRoute(
              path: ChatRoom.route,
              name: ChatRoom.routeName,
              builder: (_, __) => const ChatRoom(),
              pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const ChatRoom(),
              ),
              routes: const [],
            )
          ],
        )
      ],
    ),

    /// Login Screen
    ///   - Sign Up
    GoRoute(
        path: LoginScreenConnector.route,
        name: LoginScreenConnector.routeName,
        builder: (_, __) => const LoginScreenConnector(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const LoginScreenConnector(),
            ),
        routes: [
          GoRoute(
            path: SignUpConnector.route,
            name: SignUpConnector.routeName,
            builder: (_, __) => const SignUpConnector(),
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const SignUpConnector(),
            ),
          ),
        ]),
  ],
);

// Register the RouteObserver as a navigation observer.
final RouteObserver<ModalRoute<void>> routeObservers = RouteObserver<ModalRoute<void>>();

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(1, 1),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeIn)),
          ),
          child: child),
    );
