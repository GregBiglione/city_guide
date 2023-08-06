import 'package:city_guide/data/network/failure.dart';
import 'package:city_guide/domain/model/home.dart';

import 'package:dartz/dartz.dart';

import '../repository/repository.dart';
import 'base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, Home> {
  Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, Home>> execute(void input) async {
    return await _repository.getHome();
  }
}