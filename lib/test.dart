import 'package:city_guide/app/app.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  updateAppState() {
    MyApp.instance.appState = 1;
  }

  getAppSate() {
    print(MyApp.instance.appState);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
