import 'package:flutter/material.dart';

import '../ressource/string_manager.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppString.setting),
    );
  }
}
