import 'package:city_guide/presentation/base/base_view_model.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }
}

// Input means order that view model will receive from view --------------------
abstract class ForgotPasswordViewModelInput {
  // 2 functions for actions ---------------------------------------------------
  setEmail(String email);
  newPassword();

  // 1 sink for stream ---------------------------------------------------------
  Sink get inputEmail;
}

// Output means data/result that will be sent from view to view ----------------
abstract class ForgotPasswordViewModelOutput {
  // 1 stream for validation ---------------------------------------------------
  Stream<bool> get outputIsEmailValid;
}