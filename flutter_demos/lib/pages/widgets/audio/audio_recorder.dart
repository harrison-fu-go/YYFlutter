/* File: audio_recorder.dart
 * Created by GYGES.Harrison on 2025/8/8 at 14:09
 * Copyright © 2024 GYGES Limited.
 */

import 'package:flutter/services.dart';

class AudioRecorder {

  static const MethodChannel _channel = MethodChannel('audio_recorder');

  static void onPcmData(void Function(List<int> pcm) callback) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onReceiveRecordingPcmData') {
        final List<int> data = List<int>.from(call.arguments);
        callback(data);
      }
    });
  }

  static Future<bool> start(void Function(List<int> pcm) callback) async {
    onPcmData(callback);
    var result = await _channel.invokeMethod('startRecording');
    return result;
  }

  static Future<bool> stop() async {
    _channel.setMethodCallHandler(null);
    return await _channel.invokeMethod('stopRecording');
  }

}