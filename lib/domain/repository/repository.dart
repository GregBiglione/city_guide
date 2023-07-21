import 'package:city_guide/data/request/login_request.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/authentication.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}