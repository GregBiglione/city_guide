import 'package:city_guide/data/mapper/mapper.dart';
import 'package:city_guide/data/network/api_internal_status.dart';
import 'package:city_guide/data/network/error_data_source.dart';
import 'package:city_guide/data/network/error_data_source_extension.dart';
import 'package:city_guide/data/network/error_handler.dart';
import 'package:city_guide/data/network/failure.dart';
import 'package:city_guide/data/network/response_code.dart';
import 'package:city_guide/data/network/response_message.dart';

import 'package:city_guide/data/request/login_request.dart';
import 'package:city_guide/data/request/register_request.dart';

import 'package:city_guide/domain/model/authentication.dart';
import 'package:city_guide/domain/model/detail_store.dart';
import 'package:city_guide/domain/model/home.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repository/repository.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../network/network_info.dart';

class RepositoryImplementer implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImplementer(this._remoteDataSource, this._localDataSource,
      this._networkInfo);

  //----------------------------------------------------------------------------
  // Login
  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected) {
      try {
        // It's safe to call the API -------------------------------------------
        final response = await _remoteDataSource.login(loginRequest);

        if(response.status == ApiInternalStatus.SUCCESS) {
        // Ok ------------------------------------------------------------------
          return Right(response.toDomain());
        }
        else {
          // Business logic error ----------------------------------------------
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

  //----------------------------------------------------------------------------
  // Request new password
  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, String>> newPassword(String email) async {
    if(await _networkInfo.isConnected) {
      try {
        // It's safe to call the API -------------------------------------------
        final response = await _remoteDataSource.newPassword(email);

        if(response.status == ApiInternalStatus.SUCCESS) {
          // Ok ----------------------------------------------------------------
          return Right(response.toDomain());
        }
        else {
          // Business logic error ----------------------------------------------
          return Left(
            Failure(
                response.status ?? ResponseCode.DEFAULT,
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

  //----------------------------------------------------------------------------
  // Register
  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async {
    if(await _networkInfo.isConnected) {
      try {
        // It's safe to call the API -------------------------------------------
        final response = await _remoteDataSource.register(registerRequest);

        if(response.status == ApiInternalStatus.SUCCESS) {
          // Ok ------------------------------------------------------------------
          return Right(response.toDomain());
        }
        else {
          // Business logic error ----------------------------------------------
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

  //----------------------------------------------------------------------------
  // Home view
  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, Home>> getHome() async {
    try {
      // Get data from cache ---------------------------------------------------
      final response = await _localDataSource.getHome();

      return Right(response.toDomain());
    } catch (cacheError) {
      // Cache error get data from API -----------------------------------------
      if(await _networkInfo.isConnected) {
        try {
          // It's safe to call the API -----------------------------------------
          final response = await _remoteDataSource.getHome();

          if(response.status == ApiInternalStatus.SUCCESS) {
            // Ok --------------------------------------------------------------
            // Save response in local data source ------------------------------------
            _localDataSource.saveHomeToCache(response);

            return Right(response.toDomain());
          }
          else {
            // Business logic error --------------------------------------------
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
        // Connection error ----------------------------------------------------
        return Left(ErrorDataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  //----------------------------------------------------------------------------
  // Store detail view
  //----------------------------------------------------------------------------

  @override
  Future<Either<Failure, StoreDetail>> getStoreDetail() async {
    if(await _networkInfo.isConnected) {
      try {
        // It's safe to call the API -------------------------------------------
        final response = await _remoteDataSource.getStoreDetail();

        if(response.status == ApiInternalStatus.SUCCESS) {
          // Ok ----------------------------------------------------------------
          return Right(response.toDomain());
        }
        else {
          // Business logic error ----------------------------------------------
          return Left(
            Failure(
                response.status ?? ResponseCode.DEFAULT,
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