import 'package:city_guide/presentation/ressource/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFERENCES_KEY_LANGUAGE = "PREFERENCES_KEY_LANGUAGE";
const String PREFERENCES_KEY_ON_BOARDING_SCREEN = "PREFERENCES_KEY_ON_BOARDING_SCREEN";
const String PREFERENCES_KEY_IS_USER_LOGGED_IN = "PREFERENCES_KEY_IS_USER_LOGGED_IN";

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
}