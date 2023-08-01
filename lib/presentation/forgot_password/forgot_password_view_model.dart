import 'dart:async';

import 'package:city_guide/domain/usecase/forgot_password_usecase_input.dart';
import 'package:city_guide/presentation/base/base_view_model.dart';
import 'package:city_guide/presentation/common/new_password.dart';
import 'package:email_validator/email_validator.dart';

import '../../domain/usecase/forgot_password_usecase.dart';

class ForgotPasswordViewModel extends BaseViewModel with
    ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput{
  StreamController _emailStreamController = StreamController<String>.broadcast();
  StreamController _isAllInputValidStreamController = StreamController<void>.broadcast();
  NewPassword newPasswordObject = const NewPassword("");
  ForgotPasswordUseCase? _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  // Input ---------------------------------------------------------------------
  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;


  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

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
    _validate();
  }

  // Output --------------------------------------------------------------------
  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream
      .map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outputIsAllInputValid => _isAllInputValidStreamController.stream
      .map((_) => _isAllInputValid());

  // Private function ----------------------------------------------------------
  bool _isEmailValid(String email) {
    return email.isNotEmpty && EmailValidator.validate(email);
  }

  bool _isAllInputValid() {
    return _isEmailValid(newPasswordObject.email);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

// Input means order that view model will receive from view --------------------
abstract class ForgotPasswordViewModelInput {
  // 2 functions for actions ---------------------------------------------------
  setEmail(String email);
  newPassword();

  // 2 sinks for stream --------------------------------------------------------
  Sink get inputEmail;
  Sink get inputIsAllInputValid;
}

// Output means data/result that will be sent from view to view ----------------
abstract class ForgotPasswordViewModelOutput {
  // 2 streams for validation --------------------------------------------------
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputValid;
}