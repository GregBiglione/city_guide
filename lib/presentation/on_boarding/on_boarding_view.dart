import 'package:city_guide/presentation/ressource/color_manager.dart';
import 'package:flutter/material.dart';

import '../ressource/string_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: const Center(
          child: Text(AppString.onBoardingMessage),
      ),
    );
  }
}
