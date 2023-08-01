import 'package:city_guide/data/network/failure.dart';
import 'package:city_guide/data/request/new_password_request.dart';
import 'package:city_guide/data/response/forgot_password_response.dart';
import 'package:city_guide/domain/usecase/base_usecase.dart';
import 'package:city_guide/domain/usecase/forgot_password_usecase_input.dart';
import 'package:dartz/dartz.dart';

import '../../app/function.dart';
import '../model/device_info.dart';
import '../repository/repository.dart';

class ForgotPasswordUseCase implements BaseUseCase<ForgotPasswordUseCaseInput, ForgotPasswordResponse> {
  Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPasswordResponse>> execute(ForgotPasswordUseCaseInput input) async {
    return await _repository.newPassword(
      NewPasswordRequest(
        input.email,
      )
    );
  }
}