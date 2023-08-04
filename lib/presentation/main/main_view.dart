import 'package:city_guide/presentation/main/home_view.dart';
import 'package:city_guide/presentation/main/notification_view.dart';
import 'package:city_guide/presentation/main/search_view.dart';
import 'package:city_guide/presentation/main/setting_view.dart';
import 'package:city_guide/presentation/ressource/string_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> views = [
    const HomeView(),
    const SearchView(),
    const NotificationView(),
    const SettingView(),
  ];
  String _title = AppString.home;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: views[_currentIndex],
    );
  }
}
