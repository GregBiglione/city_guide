import 'dart:async';
import 'dart:ffi';

import 'package:city_guide/domain/model/banner.dart';
import 'package:city_guide/domain/model/home.dart';
import 'package:city_guide/domain/model/service.dart';
import 'package:city_guide/domain/usecase/home_usecase.dart';
import 'package:city_guide/presentation/common/state_renderer/state_renderer.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/model/home_data.dart';
import '../../../domain/model/store.dart';
import '../../base/base_view_model.dart';
import '../../common/state_renderer/state_renderer_implementer.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _dataStreamController = BehaviorSubject<HomeData>();

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
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  // Output --------------------------------------------------------------------
  @override
  Stream<HomeData> get outputHomeData => _dataStreamController.stream
      .map((data) => data);

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
              inputHomeData.add(HomeData(home.data.services, home.data.stores,
                home.data.banners,));
            },
    );
  }
}

// Input means order that view model will receive from view --------------------
abstract class HomeViewModelInput {
  // 1 sink for stream ---------------------------------------------------------
  Sink get inputHomeData;
}

// Output means data/result that will be sent from view to view ----------------
abstract class HomeViewModelOutput {
  // 1 stream for validation ---------------------------------------------------
  Stream<HomeData> get outputHomeData;
}
