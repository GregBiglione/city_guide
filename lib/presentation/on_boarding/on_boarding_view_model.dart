import 'dart:async';

import 'package:city_guide/domain/slider.dart';
import 'package:city_guide/presentation/base/base_view_model.dart';
import 'package:city_guide/presentation/on_boarding/on_boarding_view.dart';

import '../ressource/asset_manager.dart';
import '../ressource/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInput,
    OnBoardingViewModelOutput {
  final StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  // Input ---------------------------------------------------------------------
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderDate();
    // Send this slider date to view -------------------------------------------
    _postDataToView();
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;

    if(previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }

    return _currentIndex;
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;

    if(nextIndex >= _list.length) {
      _currentIndex = 0;
    }

    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // Output --------------------------------------------------------------------
  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController
      .stream.map((sliderViewObject) => sliderViewObject);

  // Private function ----------------------------------------------------------
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

  _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(
          _list[_currentIndex],
          _list.length,
          _currentIndex,
        ),
    );
  }
}

// Input means order that view model will receive from view --------------------
abstract class OnBoardingViewModelInput {
  void goPrevious() {}
  void goNext() {}
  void onPageChanged(int index) {}

  Sink get inputSliderViewObject;
}

// Output means data/result that will be sent from view to view ----------------
abstract class OnBoardingViewModelOutput {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject slider;
  int numberOfSlides;
  int currentIndex;

  SliderViewObject(this.slider, this.numberOfSlides, this.currentIndex);
}