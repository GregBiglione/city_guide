import 'package:city_guide/data/network/failure.dart';
import 'package:city_guide/data/request/register_request.dart';
import 'package:city_guide/domain/model/authentication.dart';
import 'package:city_guide/domain/usecase/base_usecase.dart';
import 'package:city_guide/domain/usecase/register_use_case_input.dart';
import 'package:dartz/dartz.dart';

import '../repository/repository.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput,
    Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) async {
    return await _repository.register(
      RegisterRequest(
        input.countryMobileCode,
        input.username,
        input.email,
        input.password,
        input.mobileNumber,
        input.profilePicture,
      ),
    );
  }
}