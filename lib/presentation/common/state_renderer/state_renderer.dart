import 'package:city_guide/data/mapper/mapper.dart';
import 'package:city_guide/data/network/default_failure.dart';
import 'package:flutter/material.dart';

import '../../../data/network/failure.dart';
import '../../ressource/string_manager.dart';

enum StateRenderType {
  // Popup states --------------------------------------------------------------
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  // Full screen states --------------------------------------------------------
  FULL_SCRREN_LOADING_STATE,
  FULL_SCRREN_ERROR_STATE,
  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE,
}

class StateRender extends StatelessWidget {
  StateRenderType stateRenderType;
  Failure? failure;
  String message;
  String title;
  Function retryActionFunction;

  StateRender({
    Key? key,
    required this.stateRenderType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryActionFunction,
  }) :  message = message ?? AppString.loading,
        title = title ?? EMPTY,
        failure = failure ?? DefaultFailure(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
