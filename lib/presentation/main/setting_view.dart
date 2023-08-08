import 'package:city_guide/presentation/ressource/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../ressource/asset_manager.dart';
import '../ressource/string_manager.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
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
          ),
          trailing: SvgPicture.asset(ImageAsset.settingRightArrowIc),
          onTap: () {},
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAsset.contactUsIc),
          title: Text(
            AppString.contactUs,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          trailing: SvgPicture.asset(ImageAsset.settingRightArrowIc),
          onTap: () {},
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAsset.inviteFriendsIc),
          title: Text(
            AppString.inviteYourFriends,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          trailing: SvgPicture.asset(ImageAsset.settingRightArrowIc),
          onTap: () {},
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAsset.logoutIc),
          title: Text(
            AppString.logout,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          trailing: SvgPicture.asset(ImageAsset.settingRightArrowIc),
          onTap: () {},
        ),
      ],
    );
  }
}
