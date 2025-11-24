/* File: scroll_content.dart
 * Created by GYGES.Harrison on 2025/2/24 at 16:33
 * Copyright © 2025 GYGES Limited. All rights reserved.
 */

import 'dart:async';

import 'package:flutter/material.dart';

class ScrollContentDemo extends StatefulWidget {
  const ScrollContentDemo({super.key});
  @override
  State createState() => _ScrollContentDemoState();
}

class _ScrollContentDemoState extends State<ScrollContentDemo> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  double _scrollSpeed = 50; // 每秒滚动的像素

  void startScrolling({double speed = 50, int duration = 5}) {
    _scrollSpeed = speed;
    double totalDistance = _scrollSpeed * duration; // 计算 5 秒内滚动的总距离
    double interval = 20; // 每 50 毫秒滚动一次
    int steps = (duration * 1000 / interval).round(); // 计算步数
    double stepDistance = totalDistance / steps; // 每步滚动的距离

    int stepCount = 0;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: interval.toInt()), (timer) {
      if (stepCount >= steps) {
        timer.cancel();
        _scrollController.jumpTo(0);
      } else {
        _scrollController.jumpTo(
          _scrollController.position.pixels + stepDistance,
        );
        stepCount++;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Widget text() {
    String text = "This is a sample text.";
    for (int i = 0; i < 1000; i++) {
      text = "${text}This is a sample text.";
    }
    return Text(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Scroll Control")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: text(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => startScrolling(speed: 100, duration: 5),
                child: Text("滚动 100px/s"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => startScrolling(speed: 200, duration: 5),
                child: Text("滚动 200px/s"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
