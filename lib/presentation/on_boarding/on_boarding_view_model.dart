import 'dart:async';

import 'package:city_guide/domain/slider.dart';
import 'package:city_guide/presentation/base/base_view_model.dart';
import 'package:city_guide/presentation/on_boarding/on_boarding_view.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInput,
    OnBoardingViewModelOutput {
  final StreamController _streamController = StreamController<SliderViewObject>();

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void goPrevious() {}

  @override
  void goNext() {}

  @override
  void onPageChanged(int index) {}

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => throw UnimplementedError();

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject => throw UnimplementedError();
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
  Slider slider;
  int numberOfSlides;
  int currentIndex;

  SliderViewObject(this.slider, this.numberOfSlides, this.currentIndex);
}