/* File: widgets_index_page.dart
 * Created by GYGES.Harrison on 2025/3/28 at 17:28
 * Copyright © 2025 GYGES Limited. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demos/http_link/open_link.dart';
import 'package:flutter_demos/scroll_demo/gears_scroll.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import '../../flavors.dart';
import 'my_elevated_button.dart';

class HomeDemoPage extends StatefulWidget {
  const HomeDemoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeDemoPageState();
  }
}

class _HomeDemoPageState extends State<HomeDemoPage> {
  String oldInput = '';
  @override
  void initState() {
    super.initState();
    oldInput = 'Test';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Widgets'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            IElevatedButton(
                title: 'Test Markdown',
                onTap: (index) {
                  Get.toNamed('/markdown');
                }),
            const SizedBox(height: 8),
            IElevatedButton(
                title: 'Test Keyboard',
                onTap: (index) {
                  Get.toNamed('/demoKeyboard');
                }),
            const SizedBox(height: 8),
            IElevatedButton(
                title: 'Open http link',
                onTap: (index) {
                  OpenLink.launchURL();
                }),
            const SizedBox(height: 8),
            IElevatedButton(
                title: 'Test sliders',
                onTap: (index) {
                  Get.toNamed('/sliders');
                }),
            const SizedBox(height: 8),
            IElevatedButton(
                title: 'Test Audio',
                onTap: (index) {
                  Get.toNamed('/audio');
                }),
            const SizedBox(height: 8),
            IElevatedButton(
                title: 'Test Drawer',
                onTap: (index) {
                  Get.toNamed('/drawer');
                }),
            const SizedBox(height: 8),
            IElevatedButton(
                title: 'Test -> audio_waveforms^1.3.0',
                onTap: (index) {
                  Get.toNamed('/audioWave');
                }),
            const SizedBox(height: 8),
            IElevatedButton(
                title: 'Test Mind Map',
                onTap: (index) {
                  Get.toNamed('/mindMap');
                }),
            const SizedBox(height: 8),
            IElevatedButton(
                title: 'Audio Edit Page',
                onTap: (index) {
                  Get.toNamed('/audioEdit');
                }),
          ],
        ).paddingSymmetric(horizontal: 8),
      ),
    );
  }
}
