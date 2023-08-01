import 'package:city_guide/data/request/login_request.dart';
import 'package:city_guide/data/request/new_password_request.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/authentication.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> newPassword(NewPasswordRequest newPasswordRequest);
}