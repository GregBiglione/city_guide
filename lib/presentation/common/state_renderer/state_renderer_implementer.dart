import 'package:city_guide/data/mapper/mapper.dart';
import 'package:city_guide/presentation/common/state_renderer/state_renderer.dart';
import 'package:city_guide/presentation/ressource/string_manager.dart';
import 'package:flutter/material.dart';

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

extension FlowStateExtension on FlowState {
  Widget _getWidgetScreen(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch(runtimeType) {
      case LoadingState: {
        if(getStateRenderType() == StateRenderType.POPUP_LOADING_STATE) {
          // Showing popup dialog ----------------------------------------------
          showPopUp(context, getStateRenderType(), getMessage());
          // Return the content ui of the screen -------------------------------
          return contentScreenWidget;
        }
        else {
          return StateRender(
            stateRenderType: getStateRenderType(),
            retryActionFunction: retryActionFunction,
            message: getMessage(),
          );
        }
      }
      case ErrorState: {
        if(getStateRenderType() == StateRenderType.POPUP_ERROR_STATE) {
          // Showing popup dialog ----------------------------------------------
          showPopUp(context, getStateRenderType(), getMessage());
          // Return the content ui of the screen -------------------------------
          return contentScreenWidget;
        }
        else {
          return StateRender(
            stateRenderType: getStateRenderType(),
            retryActionFunction: retryActionFunction,
            message: getMessage(),
          );
        }
      }
      case ContentState: {
        return contentScreenWidget;
      }
      case EmptyState: {
        return StateRender(
          stateRenderType: getStateRenderType(),
          retryActionFunction: retryActionFunction,
          message: getMessage(),
        );
      }
      default: {
        return contentScreenWidget;
      }
    }
  }

  showPopUp(BuildContext context, StateRenderType stateRenderType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        showDialog(
          context: context,
          builder: (BuildContext context) => StateRender(
            stateRenderType: stateRenderType,
            message: message,
            retryActionFunction: (){},
          ),
        ),
    );
  }
}