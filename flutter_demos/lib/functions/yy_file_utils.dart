import 'dart:io';

import 'package:path_provider/path_provider.dart';

class YYFileUtils {
  static String baseDirName = 'yy_files';
  static Future<Directory?> getSupportDirectoryPath({String? directory}) async {
    try {
      Directory? appDir;
      if (Platform.isIOS) {
        appDir = await getApplicationDocumentsDirectory();
      } else {
        appDir = await getApplicationSupportDirectory();
      }
      String appDocPath = "${appDir.path}/$baseDirName";
      if (directory != null) {
        appDocPath = "$appDocPath/$directory";
      }
      Directory appPath = Directory(appDocPath);
      await appPath.create(recursive: true);
      return appPath;
    } catch (e) {
      print('======> getSupportDirectoryPath error: $e');
      return null;
    }
  }
}
