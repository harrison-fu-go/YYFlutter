import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demos/utils/flower_loading.dart';
import 'package:path_provider/path_provider.dart';

class AudioEditor {
  static AudioEditor to = AudioEditor();

  //waveform controller
  PlayerController playerCtr = PlayerController();
  AudioEditor() {
    playerCtr = PlayerController();
  }

  String inputPath = '';

  Future<void> prepareDefaultAudio() async {
    try {
      final tempDir = await getTemporaryDirectory();
      File audioFile;

      // 使用 MP3 文件
      audioFile = File('${tempDir.path}/20250530095317.mp3');
      if (!await audioFile.exists()) {
        final byteData = await rootBundle.load('assets/20250530095317.mp3');
        await audioFile.writeAsBytes(byteData.buffer.asUint8List());
      }
      inputPath = audioFile.path;
      await playerCtr.preparePlayer(
        path: audioFile.path,
        shouldExtractWaveform: true,
        noOfSamples: 100,
      );
    } catch (e) {
      inputPath = '';
      print('Error preparing audio: $e');
    }
  }

  /// 裁剪音频: 例如输出为 .m4a
  Future<String?> cutAudio({
    required String inputPath,
    required double startSec,
    required double endSec,
  }) async {
    // 输出路径
    final dir = await getApplicationDocumentsDirectory();
    final outputPath =
        '${dir.path}/cut_${DateTime.now().millisecondsSinceEpoch}.mp3';

    // FFmpeg 截取命令（-ss 开始，-to 结束）
    final command =
        '-i "$inputPath" -ss $startSec -to $endSec -c copy "$outputPath"';

    print("Running FFmpeg: $command");

    final session = await FFmpegKit.execute(command);

    final returnCode = await session.getReturnCode();

    if (ReturnCode.isSuccess(returnCode)) {
      // ✔️成功
      print("FFmpeg Success → $outputPath");
      return outputPath;
    } else {
      // ❌失败
      print("FFmpeg Failed: $returnCode");
      print(await session.getLogsAsString());
      return null;
    }
  }
}
