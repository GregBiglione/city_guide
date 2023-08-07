import 'package:city_guide/data/request/login_request.dart';
import 'package:city_guide/data/request/register_request.dart';
import 'package:city_guide/domain/model/detail_store.dart';
import 'package:city_guide/domain/model/home.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/authentication.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> newPassword(String email);
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest);
  Future<Either<Failure, Home>> getHome();
  Future<Either<Failure, StoreDetail>> getStoreDetail();
}