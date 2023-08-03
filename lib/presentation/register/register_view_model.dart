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