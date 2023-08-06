import 'dart:async';
import 'dart:ffi';

import 'package:city_guide/domain/model/banner.dart';
import 'package:city_guide/domain/model/service.dart';
import 'package:city_guide/domain/usecase/home_usecase.dart';
import 'package:city_guide/presentation/common/state_renderer/state_renderer.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/model/store.dart';
import '../../base/base_view_model.dart';
import '../../common/state_renderer/state_renderer_implementer.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _bannerStreamController = BehaviorSubject<List<BannerAd>>();
  final StreamController _serviceStreamController = BehaviorSubject<List<Service>>();
  final StreamController _storeStreamController = BehaviorSubject<List<Store>>();

  HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  // Input ---------------------------------------------------------------------
  @override
  void start() {
    // View tells state to show content of the screen --------------------------
    _getHome();
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
  Stream<List<BannerAd>> get outputBanner => _bannerStreamController.stream
      .map((banner) => banner);

  @override
  Stream<List<Service>> get outputService => _serviceStreamController.stream
      .map((service) => service);

  @override
  Stream<List<Store>> get outputStore => _storeStreamController.stream
      .map((store) => store);

  // Private function ----------------------------------------------------------
  _getHome() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));

    (await _homeUseCase.execute(Void)).fold(
            (failure) {
              // Failure -------------------------------------------------------
              inputState.add(ErrorState(StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
            },
            (home) {
              // Home ----------------------------------------------------------
              inputState.add(ContentState());
              // Data inside home ----------------------------------------------
              inputBanner.add(home.data.banners);
              inputService.add(home.data.services);
              inputStore.add(home.data.stores);
            },
    );
  }
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
  Stream<List<BannerAd>> get outputBanner;
  Stream<List<Service>> get outputService;
  Stream<List<Store>> get outputStore;
}
