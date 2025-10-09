import 'package:flutter/material.dart';

class MindMapModel {
  final String title;
  final TextStyle? titleStyle;
  final double? maxTextWidth;
  final double? height;
  final List<MindMapModel>? children;
  final double? componentWith;
  Color lineColor = Colors.red;
  MindMapModel(
      {required this.title,
      this.children,
      this.componentWith,
      this.titleStyle,
      this.maxTextWidth,
      this.height});
}

TextStyle rootTitleStyle = const TextStyle(
    fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black);

TextStyle secondTitleStyle = const TextStyle(
    fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black);

TextStyle normalTitleStyle = const TextStyle(
    fontSize: 8, fontWeight: FontWeight.w400, color: Colors.black);

MindMapModel rootList = MindMapModel(
    title: 'I am the root jdjdj',
    componentWith: 30,
    maxTextWidth: 65,
    titleStyle: rootTitleStyle,
    children: secondList);
List<MindMapModel> secondList = [
  MindMapModel(
      title: 'second 1111',
      componentWith: 25,
      maxTextWidth: 80,
      titleStyle: secondTitleStyle,
      children: normalList),
  MindMapModel(
      title: 'second 2222',
      componentWith: 25,
      maxTextWidth: 80,
      titleStyle: secondTitleStyle,
      children: normalList),
  MindMapModel(
      title: 'second 3333 testtesttest',
      componentWith: 25,
      maxTextWidth: 80,
      titleStyle: secondTitleStyle,
      children: normalList),
  MindMapModel(
      title: 'second 4444',
      componentWith: 25,
      maxTextWidth: 80,
      titleStyle: secondTitleStyle,
      children: normalList),
];
List<MindMapModel> normalList = [
  MindMapModel(
      title: 'normal 1111 test',
      maxTextWidth: 130,
      titleStyle: normalTitleStyle),
  MindMapModel(
      title: 'normal 2222 test 12345678',
      maxTextWidth: 130,
      titleStyle: normalTitleStyle),
  MindMapModel(
      title: 'normal 3333 test',
      maxTextWidth: 130,
      titleStyle: normalTitleStyle),
  MindMapModel(
      title: 'normal 4444 test test',
      maxTextWidth: 130,
      titleStyle: normalTitleStyle),
];
