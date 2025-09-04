/* File: gyges_logger_db.dart
 * Created by GYGES.Harrison on 2025/3/24 at 17:21
 * Copyright © 2025 GYGES Limited. All rights reserved.
 */

import 'package:gyges_logger/gyges_logger_models.dart';
import 'package:realm/realm.dart';

class GLLoggerDB {
  static Realm? realm;

  ///add a log.
  static bool addALog(String mess, {String? userInfo, String? deviceInfo}) {
    final realm = getRealm;
    int id = getMaxId(realm) + 1;
    String ts = '${DateTime.now().millisecondsSinceEpoch}';
    var myItem =
        GLLoggerItem(id, ts, mess, userInfo ?? '', deviceInfo ?? '', 0);
    try {
      realm.write(() {
        realm.add(myItem);
      });
    } catch (error) {
      print('GLLoggerDB-> add a log error: $error');
      return false;
    }
    return true;
  }

  /// ge all logs.
  static List<GLLoggerItem> getAllLogs() {
    final realm = getRealm;
    var results = realm.all<GLLoggerItem>();
    return results.toList();
  }

  ///remove had sent logs.
  static bool removeLogs(List<GLLoggerItem> items) {
    try {
      List<int> ids = items.map((item) => item.id).toList();
      final realm = getRealm;
      var results = realm.query<GLLoggerItem>('id IN $ids');
      realm.deleteMany(results);
      return true;
    } catch (error) {
      print('GLLoggerDB-> removeLogs error: $error');
      return false;
    }
  }

  ///get the max id.
  static int getMaxId(Realm realm) {
    var items = realm.all<GLLoggerItem>();
    final maxId = items.map((e) => e.id).isEmpty
        ? 0
        : items.map((e) => e.id).reduce((a, b) => a > b ? a : b);
    return maxId;
  }

  ///get realm.
  static Realm get getRealm {
    Realm? tRealm = realm;
    if (tRealm != null) {
      return tRealm;
    }
    var config = Configuration.local([GLLoggerItem.schema]);
    var tempRealm = Realm(config);
    realm = tempRealm;
    return tempRealm;
  }
}
