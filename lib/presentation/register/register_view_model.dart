import 'dart:async';
import 'dart:io';

import 'package:city_guide/presentation/base/base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
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
  Stream<String> get outputErrorUsername;
  Stream<bool> get outputIsMobileNumberValid;
  Stream<String> get outputErrorMobileNumber;
  Stream<bool> get outputIsEmailValid;
  Stream<String> get outputErrorEmail;
  Stream<bool> get outputIsPasswordValid;
  Stream<String> get outputErrorPassword;
  Stream<File> get outputIsProfilePictureValid;
}