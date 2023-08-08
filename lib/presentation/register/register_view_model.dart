import 'dart:async';
import 'dart:io';

import 'package:city_guide/domain/usecase/register_use_case.dart';
import 'package:city_guide/domain/usecase/register_use_case_input.dart';
import 'package:city_guide/presentation/base/base_view_model.dart';
import 'package:city_guide/presentation/ressource/string_manager.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../app/function.dart';
import '../common/register.dart';
import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_implementer.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInput,
    RegisterViewModelOutput{
  final StreamController _usernameStreamController = StreamController<String>
      .broadcast();
  final StreamController _mobileNumberStreamController = StreamController<String>
      .broadcast();
  final StreamController _emailStreamController = StreamController<String>
      .broadcast();
  final StreamController _passwordStreamController = StreamController<String>
      .broadcast();
  final StreamController _profilePictureStreamController = StreamController<File>
      .broadcast();
  final StreamController _isAllInputValidStreamController = StreamController<void>
      .broadcast();
  final StreamController isUserRegisteredSuccessfullyStreamController = StreamController<bool>();
  final RegisterUseCase _registerUseCase;
  Register registerObject = const Register("", "", "", "", "", "");

  RegisterViewModel(this._registerUseCase);

   // Input ---------------------------------------------------------------------
  @override
  void start() {
    // View tells state to show content of the screen --------------------------
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _usernameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputValidStreamController.close();
    isUserRegisteredSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  setUsername(String username) {
    inputUsername.add(username);
    if(_isUsernameValid(username)) {
      // Update register object with username value ----------------------------
      registerObject = registerObject.copyWith(username: username);
    }
    else {
      // Reset value in register object ----------------------------------------
      registerObject = registerObject.copyWith(username: "");
    }
    _validate();
  }

  @override
  setCountryCode(String countryCode) {
    if(countryCode.isNotEmpty) {
      // Update register object with country code value ------------------------
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    }
    else {
      // Reset value in register object ----------------------------------------
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if(_isMobileNumberValid(mobileNumber)) {
      // Update register object with mobile number value -----------------------
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    }
    else {
      // Reset value in register object ----------------------------------------
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if(isEmailValid(email)) {
      // Update register object with email value -------------------------------
      registerObject = registerObject.copyWith(email: email);
    }
    else {
      // Reset value in register object ----------------------------------------
      registerObject = registerObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if(_isPasswordValid(password)) {
      // Update register object with password value ----------------------------
      registerObject = registerObject.copyWith(password: password);
    }
    else {
      // Reset value in register object ----------------------------------------
      registerObject = registerObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File file) {
    inputProfilePicture.add(file);
    if(file.path.isNotEmpty) {
      // Update register object with profile picture value ---------------------
      registerObject = registerObject.copyWith(profilePicture: file.path);
    }
    else {
      // Reset value in register object ----------------------------------------
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  register() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
        registerObject.countryMobileCode,
        registerObject.username,
        registerObject.email,
        registerObject.password,
        registerObject.mobileNumber,
        registerObject.profilePicture,
      ),
    )).fold(
            (failure) => {
          // Failure -----------------------------------------------------------
          inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message)),
        },
            (data) {
          // Authentication ----------------------------------------------------
          inputState.add(ContentState());
          // Navigate to main screen after register ----------------------------
          isUserRegisteredSuccessfullyStreamController.add(true);
        });
  }

  // Output --------------------------------------------------------------------
  // Username ------------------------------------------------------------------
  @override
  Stream<bool> get outputIsUsernameValid => _usernameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  Stream<String?> get outputErrorUsername =>
      outputIsUsernameValid.map((isUsernameValid) => isUsernameValid
          ? null
          : AppString.invalidUserName.tr(),
  );

  // Mobile number -------------------------------------------------------------
  @override
  Stream<bool> get outputIsMobileNumberValid => _mobileNumberStreamController.stream
      .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumberValid) => isMobileNumberValid
          ? null
          : AppString.invalidMobileNumber.tr(),
      );

  // Email ---------------------------------------------------------------------
  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream
      .map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail =>
      outputIsEmailValid.map((isEmailValid) => isEmailValid
          ? null
          : AppString.invalidEmail.tr(),
      );

  // Password ------------------------------------------------------------------
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword =>
      outputIsPasswordValid.map((isPasswordValid) => isPasswordValid
          ? null
          : AppString.invalidPassword.tr(),
      );

  // Profile picture -----------------------------------------------------------
  @override
  Stream<File?> get outputIsProfilePictureValid => _profilePictureStreamController
      .stream.map((file) => file);

  // All inputs valid ----------------------------------------------------------
  @override
  Stream<bool> get outputIsAllInputValid => _isAllInputValidStreamController
      .stream.map((_) => _isAllInputValid());

  // Private function ----------------------------------------------------------
  bool _isUsernameValid(String username) {
    return username.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _isAllInputValid() {
    return registerObject.username.isNotEmpty
        && registerObject.countryMobileCode.isNotEmpty
        && registerObject.mobileNumber.isNotEmpty
        && registerObject.email.isNotEmpty
        && registerObject.password.isNotEmpty
        && registerObject.profilePicture.isNotEmpty;
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

// Input means order that view model will receive from view --------------------
abstract class RegisterViewModelInput {
  // 7 functions for action ----------------------------------------------------
  setUsername(String username);
  setCountryCode(String countryCode);
  setMobileNumber(String mobileNumber);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File file);
  register();

  // 6 sinks for stream --------------------------------------------------------
  Sink get inputUsername;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputIsAllInputValid;
}

// Output means data/result that will be sent from view to view ----------------
abstract class RegisterViewModelOutput {
  // 10 streams for validation -------------------------------------------------
  Stream<bool> get outputIsUsernameValid;
  Stream<String?> get outputErrorUsername;
  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;
  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;
  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;
  Stream<File?> get outputIsProfilePictureValid;
  Stream<bool> get outputIsAllInputValid;
}