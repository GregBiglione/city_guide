import 'package:city_guide/presentation/ressource/route_manager.dart';
import 'package:flutter/material.dart';
import '../presentation/ressource/theme_manager.dart';

class MyApp extends StatefulWidget {
  int appState = 0;

  MyApp._internal(); // private named constructor

  static final MyApp instance = MyApp._internal(); // Single instance
  factory MyApp() => instance; // Factory for the class instance

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
