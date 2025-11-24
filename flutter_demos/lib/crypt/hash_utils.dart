/* File: hash_utils.dart
 * Created by GYGES.Harrison on 2024/11/7 at 09:17
 * Copyright © 2024 GYGES Limited.
 */

import 'dart:convert';
import 'package:crypto/crypto.dart';

String iMd5(String input) {
  List<int> bytes = utf8.encode(input);
  Digest md5Result = md5.convert(bytes);
  return md5Result.toString();
}