import 'dart:io';
import 'dart:typed_data';

import 'package:ffmpeg_kit_flutter_new_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_audio/return_code.dart';

Future<bool> wavToOgg({
  required String wavPath,
  required String oggPath,
  int sampleRate = 16000,
  int channels = 1,
  int bitrate = 24000,
}) async {
  final cmd = [
    '-y',
    '-i',
    wavPath,
    '-c:a',
    'libopus',
    '-b:a',
    '$bitrate',
    '-ar',
    '$sampleRate',
    '-ac',
    '$channels',
    oggPath,
  ].join(' ');

  final session = await FFmpegKit.execute(cmd);
  final rc = await session.getReturnCode();

  if (!ReturnCode.isSuccess(rc)) {
    final log = await session.getAllLogsAsString();
    print('===== wavToOgg wavToOgg failed: $log');
    return false;
  } else {
    print('===== wavToOgg success');
    return true;
  }
}

Future<void> pcmToOggStreamLike({
  required Stream<Uint8List> pcmStream,
  required String oggPath,
  int sampleRate = 16000,
  int channels = 1,
}) async {
  final tempPcm = File('${Directory.systemTemp.path}/temp.pcm');
  final sink = tempPcm.openWrite();

  // 分块写 PCM（低内存）
  await for (final chunk in pcmStream) {
    sink.add(chunk);
  }
  await sink.close();

  final cmd = [
    '-y',
    '-f',
    's16le',
    '-ar',
    '$sampleRate',
    '-ac',
    '$channels',
    '-i',
    tempPcm.path,
    '-c:a',
    'libopus',
    oggPath,
  ].join(' ');

  final session = await FFmpegKit.execute(cmd);
  final rc = await session.getReturnCode();

  if (!ReturnCode.isSuccess(rc)) {
    throw Exception('pcmToOgg failed');
  }

  await tempPcm.delete();
}
