import 'dart:async';

import 'package:city_guide/presentation/base/base_view_model.dart';
import 'package:city_guide/presentation/common/login.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInput,
    LoginViewModelOutput {
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  Login loginObject = Login("", "");

  // Input ---------------------------------------------------------------------
  @override
  void dispose() {
    _emailStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputUserEmail => _emailStreamController.sink;

  @override
  Sink get inputUserPassword => _passwordStreamController.sink;

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  setUserEmail(String email) {
    inputUserEmail.add(email);
    loginObject = loginObject.copyWith(email: email);
  }

  @override
  setUserPassword(String password) {
    inputUserPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
  }

  // Output --------------------------------------------------------------------
  @override
  Stream<bool> get outputIsUserEmailValid => _emailStreamController
      .stream.map((email) => _isEmailValid(email));

  @override
  // TODO: implement outputIsUserPasswordValid
  Stream<bool> get outputIsUserPasswordValid => _passwordStreamController
      .stream.map((password) => _isPasswordValid(password));

  // Private function ----------------------------------------------------------
  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }
  
  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }
}

// Input means order that view model will receive from view --------------------
abstract class LoginViewModelInput {
  // 3 functions for actions ---------------------------------------------------
  setUserEmail(String email);
  setUserPassword(String password);
  login();

  // 2 sinks for stream --------------------------------------------------------
  Sink get inputUserEmail;
  Sink get inputUserPassword;
}

// Output means data/result that will be sent from view to view ----------------
abstract class LoginViewModelOutput {
  // 2 stream for validation ---------------------------------------------------
  Stream<bool> get outputIsUserEmailValid;
  Stream<bool> get outputIsUserPasswordValid;
}