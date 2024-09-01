import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'models.dart';
import 'navigate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => ChangeModelOne()),
        ChangeNotifierProvider(create: (_) => ChangeModelTwo()),
      ],
      child: MaterialApp(
        routes: YYNavigator.routes,
        initialRoute: "/",
      ),
    );
  }
}
