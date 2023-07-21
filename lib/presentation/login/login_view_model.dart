import 'package:city_guide/presentation/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInput,
    LoginViewModelOutput {
  // Input ---------------------------------------------------------------------
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  // TODO: implement inputUserEmail
  Sink get inputUserEmail => throw UnimplementedError();

  @override
  // TODO: implement inputUserPassword
  Sink get inputUserPassword => throw UnimplementedError();

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  setUserEmail(String email) {
    // TODO: implement setUserEmail
    throw UnimplementedError();
  }

  @override
  setUserPassword(String password) {
    // TODO: implement setUserPassword
    throw UnimplementedError();
  }

  // Output --------------------------------------------------------------------
  @override
  // TODO: implement outputIsUserEmailValid
  Stream<bool> get outputIsUserEmailValid => throw UnimplementedError();

  @override
  // TODO: implement outputIsUserPasswordValid
  Stream<bool> get outputIsUserPasswordValid => throw UnimplementedError();
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