/*
 * ANCNavigate
 * Create by Harrison.Fu on 2023/10/16-11:38
 */


import 'package:demo1/main/Home.dart';
import 'package:demo1/second/second.dart';
import 'package:demo1/third/third.dart';
import 'package:flutter/material.dart';

class ANCNavigator {
  //routes config
  static Map<String, WidgetBuilder> routes = {
    "MyHome": (context) => const MyHomePage(title: 'NothingX PT'), //root.
    "Second": (context) => const SecondPage(), //root.SecondPage
    "Third": (context) => ThirdPage(), //root.
  };
}