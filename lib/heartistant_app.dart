import 'package:flutter/material.dart';
import 'package:flutter_heartistant/utilities/app_router.dart';

class HeartistantApp extends StatelessWidget {
  const HeartistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Heartistant App',
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
