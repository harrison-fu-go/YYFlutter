/*
 * AppConfig_bloc
 * Create by Harrison.Fu on 2023/10/13-16:23
 */

import 'package:demo1/main/AppConfig_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AppConfigBloc extends Cubit<AppConfigState> {
  AppConfigBloc({required AppConfigState appConfig}) : super(appConfig);
  void switchThemeColor(Color color, {Color? bgColor}) {
    if (color != state.themeColor || (bgColor != null && bgColor != state.themeBackgroundColor)) {
      emit(state.clone(color, bgColor: bgColor ?? state.themeBackgroundColor));
    }
  }
}

