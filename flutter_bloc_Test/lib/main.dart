import 'package:demo1/main/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main/AppConfig_state.dart';
import 'main/AppConfig_bloc.dart';
import 'navigate/ANCNavigate.dart';

void main() {
  runApp(BlocProvider<AppConfigBloc>(
    create: (context) => AppConfigBloc(appConfig: AppConfigState.defaultColor()),
    child: BlocBuilder<AppConfigBloc, AppConfigState>(
      builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: true,
          initialRoute: "MyHome",
          theme: ThemeData(
            primaryColor: state.themeColor,
          ),
          routes: ANCNavigator.routes
      ),
    ),
  ));
}