/* File: app_info.dart
 * Created by XianShun on 2024/9/20 at 14:50
 * Copyright © 2024 XianShun Limited.
 */
import 'package:package_info_plus/package_info_plus.dart';

class XsAppInfo {
  static XsAppInfo shared = XsAppInfo();
  Future<String> get appVersioncode async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  Future<String> get appVersionName async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}