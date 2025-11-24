/* File: YYDateTime.dart
 * Created by XianShun on 2024/9/26 at 11:30
 * Copyright © 2024 XianShun Limited.
 */

class YYDateTime {
  static int getDayStartTime(int timeStamp) {
    DateTime targetDateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return DateTime(
            targetDateTime.year, targetDateTime.month, targetDateTime.day)
        .millisecondsSinceEpoch;
  }
}
