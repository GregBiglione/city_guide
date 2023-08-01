import 'dart:async';

import 'package:city_guide/presentation/base/base_view_model.dart';
import 'package:email_validator/email_validator.dart';

class ForgotPasswordViewModel extends BaseViewModel with
    ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput{
  StreamController _emailStreamController = StreamController<String>.broadcast();

  // Input ---------------------------------------------------------------------
  @override
  void dispose() {
    _emailStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  newPassword() {
    // TODO: implement newPassword
    throw UnimplementedError();
  }

  @override
  setEmail(String email) {
    // TODO: implement setEmail
    throw UnimplementedError();
  }

  // Output --------------------------------------------------------------------
  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream
      .map((email) => _isEmailValid(email));

  // Private function ----------------------------------------------------------
  bool _isEmailValid(String email) {
    return email.isNotEmpty && EmailValidator.validate(email);
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