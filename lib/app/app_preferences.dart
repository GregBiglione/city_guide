import 'package:city_guide/presentation/ressource/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFERENCES_KEY_LANGUAGE = "PREFERENCES_KEY_LANGUAGE";
const String PREFERENCES_KEY_ON_BOARDING_SCREEN = "PREFERENCES_KEY_ON_BOARDING_SCREEN";
const String PREFERENCES_KEY_IS_USER_LOGGED_IN = "PREFERENCES_KEY_IS_USER_LOGGED_IN";
const String PREFERENCES_KEY_TOKEN = "PREFERENCES_KEY_TOKEN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getApplicationLanguage()async {
    String? language = _sharedPreferences.getString(PREFERENCES_KEY_LANGUAGE);

    if(language != null && language.isNotEmpty) {
      return language;
    }
    else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  //----------------------------------------------------------------------------
  // Set preferences for language
  //----------------------------------------------------------------------------

  Future<void> setLanguageChanged() async {
    String currentLanguage = await getApplicationLanguage();

    if(currentLanguage == LanguageType.ARABIC.getValue()) {
      // Save Preferences with english language --------------------------------
      _sharedPreferences.setString(PREFERENCES_KEY_LANGUAGE,
          LanguageType.ENGLISH.getValue());
    }
    else {
      // Save Preferences with arabic language ---------------------------------
      _sharedPreferences.setString(PREFERENCES_KEY_LANGUAGE,
          LanguageType.ARABIC.getValue());
    }
  }

  //----------------------------------------------------------------------------
  // Get locale preferences for language
  //----------------------------------------------------------------------------

  Future<Locale> getLocal() async {
    String currentLanguage = await getApplicationLanguage();

    if(currentLanguage == LanguageType.ARABIC.getValue()) {
      // Return arabic local ---------------------------------------------------
      return ARABIC_LOCALE;
    }
    else {
      // Return english local --------------------------------------------------
      return ENGLISH_LOCALE;
    }
  }

  //----------------------------------------------------------------------------
  // Set preferences for on boarding screen
  //----------------------------------------------------------------------------

  Future<void> setOnBoardingViewed() async {
    _sharedPreferences.setBool(PREFERENCES_KEY_ON_BOARDING_SCREEN, true);
  }

  //----------------------------------------------------------------------------
  // Get preferences for on boarding screen
  //----------------------------------------------------------------------------

  Future<bool> isOnBoardingViewed() async {
    return _sharedPreferences.getBool(PREFERENCES_KEY_ON_BOARDING_SCREEN)
        ?? false;
  }

  //----------------------------------------------------------------------------
  // Set preferences for user logged in
  //----------------------------------------------------------------------------

  Future<void> setIsUserLoggedIn() async {
    _sharedPreferences.setBool(PREFERENCES_KEY_IS_USER_LOGGED_IN, true);
  }

  //----------------------------------------------------------------------------
  // Get preferences for user logged in
  //----------------------------------------------------------------------------

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFERENCES_KEY_IS_USER_LOGGED_IN)
        ?? false;
  }

  //----------------------------------------------------------------------------
  // Remove preferences for user logged in
  //----------------------------------------------------------------------------

  Future<void> logout() async {
    _sharedPreferences.remove(PREFERENCES_KEY_IS_USER_LOGGED_IN);
  }

  //----------------------------------------------------------------------------
  // Set preferences for user token
  //----------------------------------------------------------------------------

  Future<void> setToken(String token) async {
    _sharedPreferences.setString(PREFERENCES_KEY_TOKEN, token);
  }

  //----------------------------------------------------------------------------
  // Get preferences for user token
  //----------------------------------------------------------------------------

  Future<String> getToken() async {
    return _sharedPreferences.getString(PREFERENCES_KEY_TOKEN) ?? "No token saved";
  }
}