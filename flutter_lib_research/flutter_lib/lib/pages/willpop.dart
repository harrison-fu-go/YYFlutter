/*
 * willpop.dart
 * Create by Harrison.Fu on 2023/11/1-16:16
 */

import 'package:flutter/material.dart';

class WillPopRoute extends StatefulWidget {
  const WillPopRoute({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<StatefulWidget> createState() => _WillPopRouteState();
}

class _WillPopRouteState extends State<WillPopRoute> {
  bool shouldPop = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
      ),
    );
  }
}