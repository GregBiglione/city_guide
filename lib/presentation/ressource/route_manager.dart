import 'package:city_guide/app/di/di.dart';
import 'package:city_guide/presentation/forgot_password/forgot_password_view.dart';
import 'package:city_guide/presentation/login/login_view.dart';
import 'package:city_guide/presentation/main/main_view.dart';
import 'package:city_guide/presentation/on_boarding/on_boarding_view.dart';
import 'package:city_guide/presentation/register/register_view.dart';
import 'package:city_guide/presentation/ressource/string_manager.dart';
import 'package:city_guide/presentation/splash/splash_view.dart';
import 'package:city_guide/presentation/store_detail/store_detail_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailRoute = "/storeDetail";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch(routeSettings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailView());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(AppString.noRouteFound),
          ),
          body: const Center(
            child: Text(AppString.noRouteFound),
          ),
        ),
    );
  }
}