import 'package:city_guide/data/mapper/mapper.dart';
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

// Error state (Pop up, full screen) -------------------------------------------
class ErrorState extends FlowState {
  StateRenderType stateRenderType;
  String message;

  ErrorState(this.stateRenderType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRenderType;
}

// Content state (Pop up, full screen) -----------------------------------------
class ContentState extends FlowState {

  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRenderType getStateRenderType() => StateRenderType.CONTENT_SCREEN_STATE;
}

// Empty state (Pop up, full screen) -----------------------------------------
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => StateRenderType.EMPTY_SCREEN_STATE;
}