/*
 * AppConfig
 * Create by Harrison.Fu on 2023/10/13-16:24
 */

import 'package:flutter/material.dart';

class AppConfigState {
  Color themeColor;
  Color? themeBackgroundColor ;
  AppConfigState({required this.themeColor, required this.themeBackgroundColor});

  AppConfigState.defaultColor()
      : themeColor = const Color(0xff3BBD5B),
       themeBackgroundColor = Colors.green;

  AppConfigState clone(Color? color, {Color? bgColor}) {
    return AppConfigState(themeColor: color ?? themeColor, themeBackgroundColor: bgColor ?? themeBackgroundColor);
  }
}
