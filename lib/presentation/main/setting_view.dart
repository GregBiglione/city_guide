import 'package:city_guide/data/data_source/local_data_source.dart';
import 'package:city_guide/presentation/ressource/language_manager.dart';
import 'package:city_guide/presentation/ressource/value_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/app_preferences.dart';
import '../../app/di/di.dart';
import '../ressource/asset_manager.dart';
import '../ressource/route_manager.dart';
import '../ressource/string_manager.dart';
import 'dart:math' as math;

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          leading: SvgPicture.asset(ImageAsset.changeLangIc),
          title: Text(
            AppString.changeLang,
            style: Theme.of(context).textTheme.headlineSmall,
          ).tr(),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isTextRightToLeft()
                ? math.pi
                : 0,
            ),
            child: SvgPicture.asset(ImageAsset.settingRightArrowIc),
          ),
          onTap: () {
            _changeLanguage();
          },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAsset.contactUsIc),
          title: Text(
            AppString.contactUs,
            style: Theme.of(context).textTheme.headlineSmall,
          ).tr(),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isTextRightToLeft()
                ? math.pi
                : 0,
            ),
            child: SvgPicture.asset(ImageAsset.settingRightArrowIc),
          ),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAsset.inviteFriendsIc),
          title: Text(
            AppString.inviteYourFriends,
            style: Theme.of(context).textTheme.headlineSmall,
          ).tr(),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isTextRightToLeft()
                ? math.pi
                : 0,
            ),
            child: SvgPicture.asset(ImageAsset.settingRightArrowIc),
          ),
          onTap: () {
            _inviteFriends();
          },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAsset.logoutIc),
          title: Text(
            AppString.logout,
            style: Theme.of(context).textTheme.headlineSmall,
          ).tr(),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isTextRightToLeft()
                ? math.pi
                : 0,
            ),
            child: SvgPicture.asset(ImageAsset.settingRightArrowIc),
          ),
          onTap: () {
            _logout();
          },
        ),
      ],
    );
  }

  //----------------------------------------------------------------------------
  // Change language
  //----------------------------------------------------------------------------

  void _changeLanguage() {
    _appPreferences.setLanguageChanged();
    // Restart to apply languages changes --------------------------------------
    Phoenix.rebirth(context);
  }

  //----------------------------------------------------------------------------
  // Check if text is right to left
  //----------------------------------------------------------------------------

  bool isTextRightToLeft() {
    return context.locale == ARABIC_LOCALE;
  }

  //----------------------------------------------------------------------------
  // Contact us
  //----------------------------------------------------------------------------

  void _contactUs() {}

  //----------------------------------------------------------------------------
  // Invite friends
  //----------------------------------------------------------------------------

  void _inviteFriends() {}

  //----------------------------------------------------------------------------
  // Logout
  //----------------------------------------------------------------------------

  void _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.pushNamed(context, Routes.loginRoute);
  }
}
