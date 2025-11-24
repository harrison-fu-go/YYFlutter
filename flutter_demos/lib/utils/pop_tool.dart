import 'package:flutter/material.dart';
import 'package:flutter_demos/utils/flower_loading.dart';
import 'package:get/get.dart';

class CustomPopTool {
  static bool _isShowing = false; // 防止重复弹出
  static BuildContext? _dialogContext;

  static Future<void> show({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
    Duration transitionDuration = const Duration(milliseconds: 300),
    bool useSafeArea = true,
  }) async {
    if (_isShowing) return;
    _isShowing = true;

    await showGeneralDialog(
      context: context,
      barrierLabel: "CustomPopTool",
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withAlpha((255 * 0.1).toInt()),
      transitionDuration: transitionDuration,
      pageBuilder: (ctx, anim1, anim2) {
        _dialogContext = ctx;
        return Container(
          color: Colors.transparent,
          child: child,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: child);
      },
    );

    _isShowing = false;
    _dialogContext = null;
  }

  static void hide() {
    if (_dialogContext != null && Navigator.of(_dialogContext!).canPop()) {
      Navigator.of(_dialogContext!).pop();
      _isShowing = false;
      _dialogContext = null;
    }
  }

  static bool get isShowing => _isShowing;
}

class CustomPartPopTool {
  static void show({
    required BuildContext context,
    required Widget child,
    double? bottom,
    double? left,
    double? right,
    double? top,
  }) {
    CustomPopTool.show(
        context: context,
        child: GestureDetector(
          onTap: () {
            CustomPopTool.hide();
          },
          child: Container(
            width: Get.width,
            height: Get.height,
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                    bottom: bottom,
                    left: left,
                    right: right,
                    top: top,
                    child: child)
              ],
            ),
          ),
        ));
  }

  static void hide() {
    CustomPopTool.hide();
  }
}

class PopLoading {
  static void show() {
    CustomPopTool.show(
      context: Get.context!,
      child: const FlowerLoading(),
    );
  }

  static void hide() {
    CustomPopTool.hide();
  }
}
