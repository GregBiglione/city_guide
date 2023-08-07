import 'package:city_guide/data/network/failure.dart';
import 'package:city_guide/domain/model/detail_store.dart';
import 'package:city_guide/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../repository/repository.dart';

class StoreDetailUseCase implements BaseUseCase<void, StoreDetail> {
  Repository _repository;

  StoreDetailUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetail>> execute(void input) async {
    return await _repository.getStoreDetail();
  }
}