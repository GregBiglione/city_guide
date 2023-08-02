import 'package:city_guide/data/mapper/mapper.dart';
import 'package:city_guide/presentation/ressource/string_manager.dart';
import 'package:city_guide/presentation/ressource/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../data/network/failure.dart';
import '../../ressource/asset_manager.dart';
import '../../ressource/color_manager.dart';
import '../../ressource/font_manager.dart';
import '../../ressource/style_manager.dart';

enum StateRendererType {
  // Popup states --------------------------------------------------------------
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  POPUP_SUCCESS,
  // Full screen states --------------------------------------------------------
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRenderType;
  String message;
  String title;
  Function? retryActionFunction;

  StateRenderer({
    Key? key,
    required this.stateRenderType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryActionFunction
  }) :  message = message ?? AppString.loading,
        title = title ?? EMPTY,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch(stateRenderType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(
            [
              _getAnimatedImage(JsonAsset.loading),
            ]
            ,
            context,
        );
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(
          [
            _getAnimatedImage(JsonAsset.error),
            _getMessage(message),
            _getRetryButton(AppString.ok, context,),
          ],
          context,
        );
      case StateRendererType.POPUP_SUCCESS:
        return _getPopUpDialog(
          [
            _getAnimatedImage(JsonAsset.success),
            _getMessage(title),
            _getMessage(message),
            _getRetryButton(AppString.ok, context),
          ],
          context,
        );
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn(
          [
            _getAnimatedImage(JsonAsset.loading),
            _getMessage(message),
          ]
        );
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn(
            [
              _getAnimatedImage(JsonAsset.error),
              _getMessage(message),
              _getRetryButton(AppString.retryAgain, context),
            ]
        );
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsInColumn(
            [
              _getAnimatedImage(JsonAsset.empty),
              _getMessage(message),
            ]
        );
      default:
        return Container();
    }
  }

  //----------------------------------------------------------------------------
  // Items in column
  //----------------------------------------------------------------------------

  Widget _getItemsInColumn(List<Widget> children) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ),
  );

  //----------------------------------------------------------------------------
  // Animated image 1st item
  //----------------------------------------------------------------------------

  Widget _getAnimatedImage(String animationName) => SizedBox(
    width: AppSize.s100,
    height: AppSize.s100,
    child: Lottie.asset(animationName),
  );

  //----------------------------------------------------------------------------
  // Message 2nd item
  //----------------------------------------------------------------------------

  Widget _getMessage(String message) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: Text(
        message,
        style: getMediumStyle(
          color: ColorManager.black,
          fontSize: FontSize.s16,
        ),
      ),
    ),
  );

  //----------------------------------------------------------------------------
  // Retry button 3rd item
  //----------------------------------------------------------------------------

  Widget _getRetryButton(String buttonTitle, BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: SizedBox(
        width: AppSize.s180,
        child: ElevatedButton(
          onPressed: (){
            if(stateRenderType == StateRendererType.FULL_SCREEN_ERROR_STATE) {
              // Call Api function to retry again ------------------------------
              retryActionFunction?.call();
            }
            else {
              // Popup error state we need to dismiss the dialog ---------------
              Navigator.of(context).pop();
            }
          },
          child: Text(buttonTitle,),
        ),
      ),
    ),
  );

  //----------------------------------------------------------------------------
  // Pop up dialog
  //----------------------------------------------------------------------------

  Widget _getPopUpDialog(List<Widget> children, BuildContext context) => Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.s14),
    ),
    elevation: AppSize.s1_5,
    backgroundColor: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: AppSize.s12,
              offset: Offset(
                AppSize.s0,
                AppSize.s12,
              ),
            ),
          ]
      ),
      child: _getDialogContent(children, context),
    ),
  );

  //----------------------------------------------------------------------------
  // Pop up dialog content
  //----------------------------------------------------------------------------

  Widget _getDialogContent(List<Widget> children, BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: children,
  );

}
