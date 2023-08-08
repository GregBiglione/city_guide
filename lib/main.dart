import 'package:city_guide/app/di/di.dart';
import 'package:city_guide/presentation/ressource/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
        supportedLocales: const [
          ENGLISH_LOCALE,
          ARABIC_LOCALE,
        ],
        path: ASSETS_PATH_LOCALISATION,
        child: Phoenix(child: MyApp()),
    )
  );
}
