import 'dart:async';

import 'package:city_guide/presentation/base/base_view_model.dart';
import 'package:city_guide/presentation/common/new_password.dart';
import 'package:email_validator/email_validator.dart';

import '../../domain/usecase/forgot_password_usecase.dart';
import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_implementer.dart';

class ForgotPasswordViewModel extends BaseViewModel with
    ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput{
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController = StreamController<void>.broadcast();
  final StreamController isResetPasswordSuccessfullyStreamController = StreamController<bool>();
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  String email = "";

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  // Input ---------------------------------------------------------------------
  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  void start() {
    // View tells state to show content of the screen --------------------------
    inputState.add(ContentState());
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;


  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  newPassword() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _forgotPasswordUseCase.execute(email)).fold(
          (failure) => {
            // Failure ---------------------------------------------------------
            inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message)),
          },
          (supportMessage) {
            // Reset password --------------------------------------------------
            inputState.add(ContentState());
            // Show success pop up ---------------------------------------------
            inputState.add(SuccessState(supportMessage));
          }
    );
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  // Output --------------------------------------------------------------------
  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream
      .map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outputIsAllInputValid => _isAllInputValidStreamController.stream
      .map((isAllInputValid) => _isAllInputValid());

  // Private function ----------------------------------------------------------
  bool _isEmailValid(String email) {
    return email.isNotEmpty && EmailValidator.validate(email);
  }

  bool _isAllInputValid() {
    return _isEmailValid(email);
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