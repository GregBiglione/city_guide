import 'package:city_guide/app/function.dart';
import 'package:city_guide/data/network/failure.dart';
import 'package:city_guide/data/request/login_request.dart';
import 'package:city_guide/domain/model/authentication.dart';
import 'package:city_guide/domain/model/device_info.dart';
import 'package:city_guide/domain/repository/repository.dart';
import 'package:city_guide/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import 'login_usecase_input.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetail();

    return await _repository.login(
        LoginRequest(
          input.username,
          input.password,
          deviceInfo.identifier,
          deviceInfo.name,
        ),
    );
  }
}