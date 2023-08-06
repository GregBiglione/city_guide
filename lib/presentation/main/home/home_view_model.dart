import 'dart:async';

import 'package:city_guide/domain/model/banner.dart';
import 'package:city_guide/domain/model/service.dart';
import 'package:city_guide/domain/usecase/home_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/model/store.dart';
import '../../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final StreamController _bannerStreamController = BehaviorSubject<List<Banner>>();
  final StreamController _serviceStreamController = BehaviorSubject<List<Service>>();
  final StreamController _storeStreamController = BehaviorSubject<List<Store>>();

  HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _bannerStreamController.close();
    _serviceStreamController.close();
    _storeStreamController.close();
    super.dispose();
  }
}