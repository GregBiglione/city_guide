import 'package:city_guide/app/app_preferences.dart';
import 'package:city_guide/presentation/ressource/route_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../presentation/ressource/theme_manager.dart';
import 'di/di.dart';

class MyApp extends StatefulWidget {
  int appState = 0;

  MyApp._internal(); // private named constructor

  static final MyApp instance = MyApp._internal(); // Single instance
  factory MyApp() => instance; // Factory for the class instance

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {
      context.setLocale(local)
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
