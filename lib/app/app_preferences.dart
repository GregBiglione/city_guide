import 'package:city_guide/presentation/ressource/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREFERENCES_KEY_LANGUAGE = "PREFERENCES_KEY_LANGUAGE";

class AppPreferences {
  SharedPreferences _sharedPreferences;

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
}