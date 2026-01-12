import 'dart:io';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConfirmExitView extends StatelessWidget {
  final Widget child;

  int lastCloseAppTimeStamp = 0;
  bool enable = true;
  void Function()? onPop;
  ConfirmExitView({
    super.key,
    this.enable = true,
    required this.child,
    this.onPop,
  });

  @override
  Widget build(BuildContext context) {
    return enable
        ? PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) {
                onPop?.call();
              }
            },
            child: child)
        : child;
  }
}
