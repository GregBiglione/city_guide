import 'package:flutter/material.dart';

enum LanguageType {
  ENGLISH,
  ARABIC
}

const String ENGLISH = "en";
const String ARABIC = "ar";
const Locale ENGLISH_LOCALE = Locale("en", "US");
const Locale ARABIC_LOCALE = Locale("ar", "SA");
const String ASSETS_PATH_LOCALISATION = "assets/translations";

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch(this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}