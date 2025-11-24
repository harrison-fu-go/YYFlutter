/*
 * Home
 * Create by Harrison.Fu on 2023/10/13-16:28
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'AppConfig_state.dart';
import 'AppConfig_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = -1;
  void _incrementCounter() {
    _counter++;
    var colors = [Colors.red, Colors.green, Colors.yellow];
    BlocProvider.of<AppConfigBloc>(context).switchThemeColor(colors[_counter], bgColor: Colors.deepOrange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConfigBloc, AppConfigState>(
        builder: (_, state) => Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: state.themeColor),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text(
              'You have pushed the button this many times:',
              style: TextStyle(color: state.themeBackgroundColor),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton.icon(
              onPressed: () {
               Navigator.pushNamed(context, "Second");
              },
              icon: const Icon(Icons.skip_next),
              label: const Text("Go to Second"),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "Third");
              },
              icon: const Icon(Icons.skip_next),
              label: const Text("Go to Third"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}