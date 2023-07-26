import 'dart:async';

import 'package:city_guide/presentation/common/state_renderer/state_renderer_implementer.dart';

abstract class BaseViewModel extends BaseViewModelInput
    with BaseViewModelOutput {
  StreamController _inputStateStreamController = StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStateStreamController.stream
      .map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }
  // Shared variables & functions that will be used in any view model ----------

}

abstract class BaseViewModelInput {
  // Will be called while view model initialization ----------------------------
  void start();

  // Will be called while view model dies --------------------------------------
  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutput {
  Stream<FlowState> get outputState;
}