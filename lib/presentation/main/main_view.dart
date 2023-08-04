import 'package:city_guide/presentation/main/home_view.dart';
import 'package:city_guide/presentation/main/notification_view.dart';
import 'package:city_guide/presentation/main/search_view.dart';
import 'package:city_guide/presentation/main/setting_view.dart';
import 'package:city_guide/presentation/ressource/color_manager.dart';
import 'package:city_guide/presentation/ressource/string_manager.dart';
import 'package:city_guide/presentation/ressource/value_manager.dart';
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
  List<String> titles = [
    AppString.home,
    AppString.search,
    AppString.notification,
    AppString.setting,
  ];
  late String _title = AppString.home;
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManager.lightGrey,
              spreadRadius: AppSize.s1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          onTap: switchIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: AppString.home
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
                label: AppString.search
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              label: AppString.notification
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: AppString.setting
            ),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  // Switch index
  //----------------------------------------------------------------------------

  void switchIndex(selectedIndex){
    setState(() {
      _currentIndex = selectedIndex;
      _title = titles[_currentIndex];
    });
  }
}
