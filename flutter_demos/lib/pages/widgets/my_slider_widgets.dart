/* File: my_slider_widgets.dart
 * Created by GYGES.Harrison on 2025/9/4 at 18:19
 * Copyright © 2024 GYGES Limited.
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../scroll_demo/gears_scroll.dart';

class SlidersPage extends StatelessWidget {

  const SlidersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sliders'),
        ),
        body: const Column(
          children: [
            SizedBox(height: 32),
            SlotSlider(),
          ],
        ).paddingSymmetric(horizontal: 16));
  }


}