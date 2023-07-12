import 'package:city_guide/presentation/color_manager.dart';
import 'package:city_guide/presentation/font_manager.dart';
import 'package:city_guide/presentation/style_manager.dart';
import 'package:city_guide/presentation/value_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Colors of the app -------------------------------------------------------
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),

    // Ripple theme ------------------------------------------------------------
    splashColor: ColorManager.primaryOpacity70,
    // Card view theme ---------------------------------------------------------
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // App bar theme -----------------------------------------------------------
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.primaryOpacity70,
      titleTextStyle: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
    ),

    // Button theme ------------------------------------------------------------
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),
    // Elevated button theme ---------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    // Text theme --------------------------------------------------------------
    // Input decoration theme text form field ----------------------------------

  );
}