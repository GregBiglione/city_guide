import 'dart:io';

import 'package:flutter/services.dart';

import '../domain/model/device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<DeviceInfo> getDeviceDetail() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String name = "Unknown";
  String? identifier = "Unknown";
  String version = "Unknown";

  try {
    if(Platform.isAndroid) {
      AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
      name = "${build.brand} ${build.model}";
      identifier = build.id;
      version = build.version.codename;
    }
    else if(Platform.isIOS) {
      IosDeviceInfo build = await deviceInfoPlugin.iosInfo;
      name = "${build.name} ${build.model}";
      identifier = build.identifierForVendor;
      version = build.systemVersion;
    }
  } on PlatformException {
    return DeviceInfo(name, identifier!, version);
  }

  return DeviceInfo(name, identifier!, version);
}