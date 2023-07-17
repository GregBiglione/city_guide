import 'package:city_guide/presentation/ressource/asset_manager.dart';
import 'package:city_guide/presentation/ressource/color_manager.dart';
import 'package:city_guide/presentation/ressource/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../ressource/string_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list = _getSliderDate();
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  List<SliderObject> _getSliderDate() => [
    SliderObject(AppString.onBoardingTitle1,
        AppString.onBoardingSubTitle1, ImageAsset.onBoardingLogo1),
    SliderObject(AppString.onBoardingTitle2,
        AppString.onBoardingSubTitle2, ImageAsset.onBoardingLogo2),
    SliderObject(AppString.onBoardingTitle3,
        AppString.onBoardingSubTitle3, ImageAsset.onBoardingLogo3),
    SliderObject(AppString.onBoardingTitle4,
        AppString.onBoardingSubTitle4, ImageAsset.onBoardingLogo4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: AppSize.s1_5,
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
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(_list[index]);
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

                  },
                  child: const Text(
                    AppString.skip,
                    textAlign: TextAlign.end,
                  )
              ),
            ),
            _getBottomSheet(),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheet() => Row(
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

          },
        ),
      ),
      // Circle indicator --------------------------------------------------------
      Row(
        children: [
          for(int i = 0; i < _list.length; i++)
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: _getProperCircle(i),
            ),
        ],
      ),
      // Right arrow -------------------------------------------------------------
      Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: GestureDetector(
          child: SizedBox(
            width: AppSize.s20,
            height: AppSize.s20,
            child: SvgPicture.asset(ImageAsset.rightArrowIc),
          ),
          onTap: () {

          },
        ),
      ),
    ],
  );

  Widget _getProperCircle(int index) {
    if(index == _currentIndex) {
      return SvgPicture.asset(ImageAsset.hollowCircleIc);
    }
    else {
      return SvgPicture.asset(ImageAsset.solidCircleIc);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  SliderObject _sliderObject;

  OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

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


class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}