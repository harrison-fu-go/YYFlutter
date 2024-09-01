/*
 * Models
 * Create by Harrison.Fu on 2024/8/23-14:59
 */
import 'package:flutter/material.dart';

class ChangeModelOne with ChangeNotifier{
  int count = 1;

  void setCount(int count) {
    print("====== setCount ");
    this.count = count;
    notifyListeners();
  }
}

class ChangeModelTwo with ChangeNotifier{
  String _name = '啥也没有';
  set name(String newName) {
    _name = newName;
    notifyListeners();
  }
  String get name {
    return _name;
  }
}


class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}