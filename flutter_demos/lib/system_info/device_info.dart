/* File: device_info.dart
 * Created by XianShun on 2024/9/20 at 14:35
 * Copyright © 2024 XianShun Limited.
 */

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class XsDeviceInfo {
  static XsDeviceInfo shared = XsDeviceInfo();
  final String osIos = 'ios';
  final String osAndroid = 'android';
  final String osOthers = 'unknown';
  String get osType {
    if (Platform.isIOS) {
      return osIos;
    } else if (Platform.isAndroid) {
      return osAndroid;
    } else {
      return osOthers;
    }
  }

  int get osTypeInt {
    if (Platform.isIOS) {
      return 2;
    } else if (Platform.isAndroid) {
      return 1;
    } else {
      return -1;
    }
  }

  Future<String> get osVersion async { //手机系统版本
    var deviceInfo = DeviceInfoPlugin();
    if (osType == osIos) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.systemVersion;
    } else if(osType == 'android'){
      var androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.release;
    } else {
      return 'unknown';
    }
  }
}