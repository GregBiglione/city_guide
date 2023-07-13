import 'package:city_guide/presentation/ressource/color_manager.dart';
import 'package:flutter/material.dart';

import '../ressource/asset_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
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
