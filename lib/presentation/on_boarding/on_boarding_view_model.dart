import 'package:city_guide/presentation/base/base_view_model.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInput,
    OnBoardingViewModelOutput {
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
}

// Input means order that view model will receive from view --------------------
abstract class OnBoardingViewModelInput {
  void goPrevious() {}
  void goNext() {}
  void onPageChanged(int index) {}
}

// Output means data/result that will be sent from view to view ----------------
abstract class OnBoardingViewModelOutput {}