import 'package:city_guide/data/mapper/mapper.dart';
import 'package:city_guide/data/network/api_internal_status.dart';
import 'package:city_guide/data/network/error_data_source.dart';
import 'package:city_guide/data/network/error_data_source_extension.dart';
import 'package:city_guide/data/network/error_handler.dart';
import 'package:city_guide/data/network/failure.dart';
import 'package:city_guide/data/network/response_code.dart';
import 'package:city_guide/data/network/response_message.dart';

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
      try {
        // It(s safe to call the API ---------------------------------------------
        final response = await _remoteDataSource.login(loginRequest);

        if(response.status == ApiInternalStatus.SUCCESS) {
        // Ok ------------------------------------------------------------------
          return Right(response.toDomain());
        }
        else {
          // Business logic error ------------------------------------------------
          return Left(
              Failure(
                response.status ?? ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT
              ),
          );
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    }
    else {
      // Connection error ------------------------------------------------------
      return Left(ErrorDataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}