import 'package:city_guide/presentation/common/state_renderer/state_renderer.dart';
import 'package:city_guide/presentation/ressource/string_manager.dart';

abstract class FlowState {
  StateRenderType getStateRenderType();
  String getMessage();
}

// Loading state (Pop up, full screen) -----------------------------------------
class LoadingState extends FlowState {
  StateRenderType stateRenderType;
  String message;

  LoadingState({required this.stateRenderType, String? message}):
      message = message ?? AppString.loading;

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRenderType;
}