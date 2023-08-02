import 'package:city_guide/data/mapper/mapper.dart';
import 'package:city_guide/presentation/common/state_renderer/state_renderer.dart';
import 'package:city_guide/presentation/ressource/string_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRenderType();
  String getMessage();
}

// Loading state (Pop up, full screen) -----------------------------------------
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message}) :
        message = message ?? AppString.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderType() => stateRendererType;
}

// Error state (Pop up, full screen) -------------------------------------------
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderType() => stateRendererType;
}

// Content state (Pop up, full screen) -----------------------------------------
class ContentState extends FlowState {

  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRenderType() => StateRendererType.CONTENT_SCREEN_STATE;
}

// Empty state (Pop up, full screen) -------------------------------------------
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderType() => StateRendererType.EMPTY_SCREEN_STATE;
}

// Success state ---------------------------------------------------------------
class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderType() => StateRendererType.POPUP_SUCCESS;
}

extension FlowStateExtension on FlowState {
  Widget getWidgetScreen(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch(runtimeType) {
      case LoadingState: {
        if(getStateRenderType() == StateRendererType.POPUP_LOADING_STATE) {
          // Showing popup dialog ----------------------------------------------
          showPopUp(context, getStateRenderType(), getMessage());
          // Return the content ui of the screen -------------------------------
          return contentScreenWidget;
        }
        else {
          // StateRendererType.FULL_SCREEN_LOADING_STATE -----------------------
          return StateRenderer(
              stateRenderType: getStateRenderType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
          );
        }
      }
      case ErrorState: {
        dismissDialog(context);
        if(getStateRenderType() == StateRendererType.POPUP_ERROR_STATE) {
          // Showing popup dialog ----------------------------------------------
          showPopUp(context, getStateRenderType(), getMessage());
          // Return the content ui of the screen -------------------------------
          return contentScreenWidget;
        }
        else {
          // StateRendererType.FULL_SCREEN_ERROR_STATE -----------------------
          return StateRenderer(
            stateRenderType: getStateRenderType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }
      }
      case ContentState: {
        dismissDialog(context);
        return contentScreenWidget;
      }
      case EmptyState: {
        return StateRenderer(
          stateRenderType: getStateRenderType(),
          message: getMessage(),
          retryActionFunction: retryActionFunction,
        );
      }
      case SuccessState: {
        dismissDialog(context);
        showPopUp(context, getStateRenderType(), getMessage(),
            title: AppString.successTitle);
        return contentScreenWidget;
      }
      default: {
        return contentScreenWidget;
      }
    }
  }

  //----------------------------------------------------------------------------
  // Display dialog
  //----------------------------------------------------------------------------

  showPopUp(BuildContext context, StateRendererType stateRenderType,
      String message, {String? title}) {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        showDialog(
          context: context,
          builder: (BuildContext context) => StateRenderer(
            stateRenderType: stateRenderType,
            message: message,
            title: title,
            retryActionFunction: (){},
          ),
        ),
    );
  }

  //----------------------------------------------------------------------------
  // Handling showing many popup dialogs
  //----------------------------------------------------------------------------

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  //----------------------------------------------------------------------------
  // Dismiss dialog
  //----------------------------------------------------------------------------

  dismissDialog(BuildContext context) {
    if(_isThereCurrentDialogShowing(context)) {
      Navigator.of(
        context,
        rootNavigator: true,
      ).pop(true);
    }
  }
}