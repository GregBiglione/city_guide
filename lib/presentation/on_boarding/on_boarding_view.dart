import 'package:city_guide/presentation/on_boarding/on_boarding_view_model.dart';
import 'package:city_guide/presentation/ressource/asset_manager.dart';
import 'package:city_guide/presentation/ressource/color_manager.dart';
import 'package:city_guide/presentation/ressource/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/slider.dart';
import '../ressource/route_manager.dart';
import '../ressource/string_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) =>
      sliderViewObject != null
          ? Scaffold(
              appBar: AppBar(
                elevation: AppSize.s0,
                backgroundColor: ColorManager.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: ColorManager.white,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarIconBrightness: Brightness.dark,
                ),
              ),
              backgroundColor: ColorManager.white,
              body: PageView.builder(
                controller: _pageController,
                itemCount: sliderViewObject.numberOfSlides,
                onPageChanged: (index) {
                  /*setState(() {
                    _currentIndex = index;
                  });*/
                  _viewModel.onPageChanged(index);
                },
                itemBuilder: (context, index) {
                  return OnBoardingPage(sliderViewObject.slider);
                },
              ),
              bottomSheet: Container(
                color: ColorManager.white,
                height: AppSize.s100,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute);
                          },
                          child: Text(
                            AppString.skip,
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.end,
                          )),
                    ),
                    _getBottomSheet(sliderViewObject),
                  ],
                ),
              ),
            )
          : Container();

  Widget _getBottomSheet(SliderViewObject sliderViewObject) => Container(
        color: ColorManager.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left arrow --------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(ImageAsset.leftArrowIc),
                ),
                onTap: () {
                  // Go to previous slide --------------------------------------------
                  _pageController.animateToPage(
                    //_getPreviousIndex(),
                    _viewModel.goPrevious(),
                    duration: const Duration(
                      milliseconds: DurationConstant.d300,
                    ),
                    curve: Curves.bounceInOut,
                  );
                },
              ),
            ),
            // Circle indicator ------------------------------------------------------
            Row(
              children: [
                for (int i = 0; i < sliderViewObject.numberOfSlides; i++)
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: _getProperCircle(i, sliderViewObject.currentIndex),
                  ),
              ],
            ),
            // Right arrow -----------------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(ImageAsset.rightArrowIc),
                ),
                onTap: () {
                  // Go to next slide ------------------------------------------------
                  _pageController.animateToPage(
                    //_getNextIndex(),
                    _viewModel.goNext(),
                    duration: const Duration(
                      milliseconds: DurationConstant.d300,
                    ),
                    curve: Curves.bounceInOut,
                  );
                },
              ),
            ),
          ],
        ),
      );

  Widget _getProperCircle(int index, currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAsset.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAsset.solidCircleIc);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}
