/* File: my_stateless_demo_page.dart
 * Created by GYGES.Harrison on 2025/9/4 at 17:49
 * Copyright © 2024 GYGES Limited.
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatelessDemoPage extends StatelessWidget {

  const StatelessDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
        title: const Text('Hello develop'),
    ),
    body: const Text('Module in developing...').paddingSymmetric(horizontal: 16));
  }


}