/* File: share.dart
 * Created by GYGES.Harrison on 2025/3/27 at 18:02
 * Copyright © 2025 GYGES Limited. All rights reserved.
 */

import 'package:share_plus/share_plus.dart';

class YYShare {
  static void shareTextWithSubject(String text, String subject) async {
    ///这里可以存放loading...
    await Share.share(text, subject: subject);
    ///这里loading... end.
  }

}