import 'dart:async';

import 'package:city_guide/domain/usecase/login_usecase.dart';
import 'package:city_guide/domain/usecase/login_usecase_input.dart';
import 'package:city_guide/presentation/base/base_view_model.dart';
import 'package:city_guide/presentation/common/login.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInput,
    LoginViewModelOutput {
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController = StreamController<void>.broadcast();
  Login loginObject = const Login("", "");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  // Input ---------------------------------------------------------------------
  @override
  void dispose() {
    _emailStreamController.close();
    _passwordStreamController.close();
    _isAllInputValidStreamController.close();
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
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  login() async {
    (await _loginUseCase.execute(
        LoginUseCaseInput(
            loginObject.email,
            loginObject.password),
    )).fold((failure) => {
      // Failure ---------------------------------------------------------------
      print(failure.message)
    }, (data) => {
      // Authentication --------------------------------------------------------
      print(data.customer?.name)
    });
  }

  @override
  setUserEmail(String email) {
    inputUserEmail.add(email);
    loginObject = loginObject.copyWith(email: email);
    _validate();
  }

  @override
  setUserPassword(String password) {
    inputUserPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  // Output --------------------------------------------------------------------
  @override
  Stream<bool> get outputIsUserEmailValid => _emailStreamController
      .stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outputIsUserPasswordValid => _passwordStreamController
      .stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsAllInputValid => _isAllInputValidStreamController
      .stream.map((_) => _isAllInputValid());

  // Private function ----------------------------------------------------------
  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }
  
  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isAllInputValid() {
    return _isEmailValid(loginObject.email) && _isPasswordValid(loginObject.password);
  }

  _validate() {
    inputIsAllInputValid.add(null);
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
  Sink get inputIsAllInputValid;
}

// Output means data/result that will be sent from view to view ----------------
abstract class LoginViewModelOutput {
  // 2 stream for validation ---------------------------------------------------
  Stream<bool> get outputIsUserEmailValid;
  Stream<bool> get outputIsUserPasswordValid;
  Stream<bool> get outputIsAllInputValid;
}