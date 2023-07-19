import 'package:city_guide/data/mapper/mapper.dart';
import 'package:city_guide/data/network/failure.dart';

import 'package:city_guide/data/request/login_request.dart';

import 'package:city_guide/domain/authentication.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/network_info.dart';

class RepositoryImplementer implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImplementer(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected) {
      // It(s safe to call the API ---------------------------------------------
      final response = await _remoteDataSource.login(loginRequest);

      if(response.status == 0) {
        // Ok ------------------------------------------------------------------
        return Right(response.toDomain());
      }
      else {
        // Business logic error ------------------------------------------------
        return Left(
            Failure(
                409,
                response.message ?? "We have business logic error from API side"
            ),
        );
      }
    }
    else {
      // Connection error ------------------------------------------------------
      return Left(Failure(501, "Please check your internet connection"));
    }
  }
}