/*
 * test_page_one
 * Create by Harrison.Fu on 2024/8/26-15:36
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models.dart';

class TestPageOnePage extends StatefulWidget {
  const TestPageOnePage({super.key});
  @override
  State<TestPageOnePage> createState() => _TestPageOneState();
}

class _TestPageOneState extends State<TestPageOnePage> {
  @override
  Widget build(BuildContext context) {
   var name = Provider.of<ChangeModelTwo>(context, listen: false).name;
    // TODO: implement build
    return Scaffold(
        body: SafeArea(child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${context.read<Counter>().count}"),
              Text("${context.read<ChangeModelOne>().count}"),
              Text("${name}"),
            ],
          ),
        ),
          top: true,)
    );
  }
}
