/* File: my_audio_test_page.dart
 * Created by GYGES.Harrison on 2025/9/5 at 09:42
 * Copyright © 2024 GYGES Limited.
 */

import 'package:flutter/material.dart';
import 'package:flutter_demos/pages/widgets/audio/audio_recorder.dart';
import 'package:flutter_demos/pages/widgets/my_elevated_button.dart';
import 'package:get/get.dart';

class MyAudioTestPage extends StatefulWidget {
  const MyAudioTestPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return MyAudioTestPageState();
  }
}

class MyAudioTestPageState extends State<MyAudioTestPage> {
  // const MyAudioTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Test'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          IElevatedButton(
            title: '开始/结束录音',
            onTap: (idx) {
              AudioRecorder.start((success) {});
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
