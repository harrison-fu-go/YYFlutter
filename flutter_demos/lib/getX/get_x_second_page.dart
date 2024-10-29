

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'get_x_controller.dart';
class SecondPage extends StatelessWidget {
  final CounterController counterController = Get.find(); // 获取已存在的控制器实例

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Obx(() => Text(
          'Count: ${counterController.count}',
          style: const TextStyle(fontSize: 30),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterController.increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}