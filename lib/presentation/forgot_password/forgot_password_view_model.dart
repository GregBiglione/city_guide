import 'dart:async';

import 'package:city_guide/domain/usecase/forgot_password_usecase_input.dart';
import 'package:city_guide/presentation/base/base_view_model.dart';
import 'package:city_guide/presentation/common/new_password.dart';
import 'package:email_validator/email_validator.dart';

import '../../domain/usecase/forgot_password_usecase.dart';

class ForgotPasswordViewModel extends BaseViewModel with
    ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput{
  StreamController _emailStreamController = StreamController<String>.broadcast();
  NewPassword newPasswordObject = const NewPassword("");
  ForgotPasswordUseCase? _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

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
  newPassword() async {
    (await _forgotPasswordUseCase?.execute(
        ForgotPasswordUseCaseInput(
          newPasswordObject.email,
        )
    ))?.fold(
          (failure) => {
            // Failure ---------------------------------------------------------
            print(failure.message)
          },
          (data) {
            // Authentication --------------------------------------------------
            print(data.message);
            // Navigate to main screen after login -----------------------------
          }
    );
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    newPasswordObject = newPasswordObject.copyWith(email: email);
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