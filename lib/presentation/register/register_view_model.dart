import 'dart:async';
import 'dart:io';

import 'package:city_guide/domain/usecase/register_use_case.dart';
import 'package:city_guide/presentation/base/base_view_model.dart';
import 'package:city_guide/presentation/ressource/string_manager.dart';

import '../../app/function.dart';

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
  final StreamController _isAllInputValidStreamController = StreamController<String>
      .broadcast();
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

   // Input ---------------------------------------------------------------------
  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _usernameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputValidStreamController.close();
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
  register() {
    // TODO: implement register
    throw UnimplementedError();
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
          : AppString.invalidUserName,
  );

  // Mobile number -------------------------------------------------------------
  @override
  Stream<bool> get outputIsMobileNumberValid => _mobileNumberStreamController.stream
      .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumberValid) => isMobileNumberValid
          ? null
          : AppString.invalidMobileNumber,
      );

  // Email ---------------------------------------------------------------------
  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream
      .map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail =>
      outputIsEmailValid.map((isEmailValid) => isEmailValid
          ? null
          : AppString.invalidEmail,
      );

  // Password ------------------------------------------------------------------
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword =>
      outputIsPasswordValid.map((isPasswordValid) => isPasswordValid
          ? null
          : AppString.invalidPassword,
      );

  // Profile picture -----------------------------------------------------------
  @override
  Stream<File> get outputIsProfilePictureValid => _profilePictureStreamController
      .stream.map((file) => file);

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
}

// Input means order that view model will receive from view --------------------
abstract class RegisterViewModelInput {
  // 1 function for action -----------------------------------------------------
  register();

  // 5 sinks for stream --------------------------------------------------------
  Sink get inputUsername;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
}

// Output means data/result that will be sent from view to view ----------------
abstract class RegisterViewModelOutput {
  // 9 streams for validation --------------------------------------------------
  Stream<bool> get outputIsUsernameValid;
  Stream<String?> get outputErrorUsername;
  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;
  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;
  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;
  Stream<File> get outputIsProfilePictureValid;
}