/* File: app_screen_styles.dart
 * Created by GYGES.Harrison on 2025/8/13 at 10:19
 * Copyright © 2024 GYGES Limited.
 */

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainScreen {
  static BuildContext? get context {
    return Get.context;
  }

  static double get screenH {
    double h = 0;
    if (context != null) {
      h = MediaQuery.of(context!).size.height;
    }
    return h;
  }

  static double get screenW {
    double w = 0;
    if (context != null) {
      w = MediaQuery.of(context!).size.width;
    }
    return w;
  }

  static double contentWidth({required double padding}) {
    double w = 0;
    if (context != null) {
      w = MediaQuery.of(context!).size.width;
    }
    return w - 2.0 * padding;
  }

  static Size sizeOf({BuildContext? ctx}) {
    Size size = const Size(0, 0);
    BuildContext? iCtx = ctx;
    iCtx ??= context;
    if (iCtx != null) {
      size = MediaQuery.of(iCtx).size;
    }
    return size;
  }

  static double get bottomSafeH {
    double bottomSafeH = 0;
    if (context != null) {
      bottomSafeH = MediaQuery.of(context!).padding.bottom;
    }
    return bottomSafeH;
  }

  static double get topSafeH {
    BuildContext? context = Get.context;
    double safeH = 0;
    if (context != null) {
      safeH = MediaQuery.of(context).padding.top;
    }
    return safeH;
  }

  static double get leftSafeW {
    BuildContext? context = Get.context;
    double safeH = 0;
    if (context != null) {
      safeH = MediaQuery.of(context).padding.left;
    }
    return safeH;
  }

  static double get rightSafeW {
    BuildContext? context = Get.context;
    double safeH = 0;
    if (context != null) {
      safeH = MediaQuery.of(context).padding.right;
    }
    return safeH;
  }

  static double get appBarH {
    return 56;
  }

  static double bottomNavigationBarH = 57;

  static double get bottomAllBarH {
    return bottomNavigationBarH + bottomSafeH;
  }
}
