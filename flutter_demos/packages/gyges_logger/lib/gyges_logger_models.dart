/* File: gyges_logger_database.dart
 * Created by GYGES.Harrison on 2025/3/24 at 16:31
 * Copyright © 2025 GYGES Limited. All rights reserved.
 */
import 'package:realm/realm.dart';
part 'gyges_logger_models.realm.dart';

/// run: "dart run realm generate" to generate .realm.dart file.


@RealmModel()
class _GLLoggerItem {

  @PrimaryKey()
  late int id;

  late String ts;

  late String log;

  //user's information, email, name, account...
  late String userInfo;

  //device's json information.
  late String deviceInfo;

  late int status;
}
