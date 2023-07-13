import 'dart:async';

import 'package:city_guide/presentation/ressource/color_manager.dart';
import 'package:flutter/material.dart';

import '../ressource/asset_manager.dart';
import '../ressource/route_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  //----------------------------------------------------------------------------
  // Start timer
  //----------------------------------------------------------------------------

  _startDelay(){
    _timer = Timer(
      const Duration(
        seconds: 2,
      ), _goNext,
    );
  }

  _goNext(){
    Navigator.pushReplacementNamed(
        context,
        Routes.onBoardingRoute,
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    // Cancel timer ------------------------------------------------------------
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(
          image: AssetImage(ImageAsset.splashLogo),
        ),
      ),
    );
  }
}
