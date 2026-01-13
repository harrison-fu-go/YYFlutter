/* File: my_audio_test_page.dart
 * Created by GYGES.Harrison on 2025/9/5 at 09:42
 * Copyright © 2024 GYGES Limited.
 */

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/functions/yy_file_utils.dart';
import 'package:flutter_demos/functions/yy_wav_to_ogg.dart';
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
  String? _audioFilePath;
  String? wavToOggResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Test'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          IElevatedButton(
            title: '开始/结束录音',
            onTap: (idx) {
              AudioRecorder.start((success) {});
            },
          ),
          const Text('--------------------------------'),
          Row(
            children: [
              const Text('选择音频wav文件: '),
              IconButton(
                  onPressed: () async {
                    _pickAudioFile();
                  },
                  icon: const Icon(Icons.file_present)),
            ],
          ),
          if (_audioFilePath != null)
            Row(
              children: [
                const Text('音频文件: '),
                Text(_audioFilePath!.split('/').last),
              ],
            ),
          if (_audioFilePath != null) ...[
            const SizedBox(height: 8),
            IElevatedButton(
              title: 'Wav to Ogg',
              onTap: (idx) {
                _wavToOgg();
              },
            ),
            const SizedBox(height: 8),
            if (wavToOggResult != null)
              Text('Wav to Ogg result: $wavToOggResult'),
          ],
          const Text('--------------------------------'),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }

  Future<void> _wavToOgg() async {
    Directory? toPath = await YYFileUtils.getSupportDirectoryPath();
    if (toPath == null) {
      return;
    }
    String fileName =
        _audioFilePath!.split('/').last.replaceAll('.wav', '.ogg');
    String toPathFile = '${toPath.path}/$fileName';
    bool success =
        await wavToOgg(wavPath: _audioFilePath!, oggPath: toPathFile);
    setState(() {
      wavToOggResult = success ? 'Success' : 'Failed';
    });
  }

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['wav'],
    );
    if (result == null) {
      return;
    }
    PlatformFile chooseFile = result.files.first;
    if (chooseFile.path == null) {
      return;
    }
    String? filePath = chooseFile.path;
    if (filePath == null) {
      print('===== filePath is null');
      return;
    }
    setState(() {
      _audioFilePath = filePath;
    });
    print('===== did selecte file: $filePath');
  }
}
