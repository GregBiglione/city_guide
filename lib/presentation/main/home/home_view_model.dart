import 'dart:async';

import 'package:city_guide/domain/model/banner.dart';
import 'package:city_guide/domain/model/service.dart';
import 'package:city_guide/domain/usecase/home_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/model/store.dart';
import '../../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _bannerStreamController = BehaviorSubject<List<Banner>>();
  final StreamController _serviceStreamController = BehaviorSubject<List<Service>>();
  final StreamController _storeStreamController = BehaviorSubject<List<Store>>();

  HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  // Input ---------------------------------------------------------------------
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

  @override
  Sink get inputBanner => _bannerStreamController.sink;

  @override
  Sink get inputService => _serviceStreamController.sink;

  @override
  Sink get inputStore => _storeStreamController.sink;

  // Output --------------------------------------------------------------------
  @override
  Stream<List<Banner>> get outputBanner => _bannerStreamController.stream
      .map((banner) => banner);

  @override
  Stream<List<Service>> get outputService => _serviceStreamController.stream
      .map((service) => service);

  @override
  Stream<List<Store>> get outputStore => _storeStreamController.stream
      .map((store) => store);
}

// Input means order that view model will receive from view --------------------
abstract class HomeViewModelInput {
  // 3 sinks for stream --------------------------------------------------------
  Sink get inputBanner;
  Sink get inputService;
  Sink get inputStore;
}

// Output means data/result that will be sent from view to view ----------------
abstract class HomeViewModelOutput {
  // 3 streams for validation --------------------------------------------------
  Stream<List<Banner>> get outputBanner;
  Stream<List<Service>> get outputService;
  Stream<List<Store>> get outputStore;
}
