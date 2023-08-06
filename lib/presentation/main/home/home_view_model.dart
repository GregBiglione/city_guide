import 'package:city_guide/domain/usecase/home_usecase.dart';

import '../../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}