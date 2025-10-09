/* File: my_stateless_demo_page.dart
 * Created by GYGES.Harrison on 2025/9/4 at 17:49
 * Copyright © 2024 GYGES Limited.
 */

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demos/styles/my_colors.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';

class MyAudioWavePage extends StatefulWidget {
  const MyAudioWavePage({super.key});

  @override
  State<MyAudioWavePage> createState() => WaveformPageState();
}

class WaveformPageState extends State<MyAudioWavePage> {
  late PlayerController playerCtr;
  bool _isPlaying = false;
  String? _audioPath;
  bool _isLoading = true;
  String? _errorMessage;

  double get sW => Get.width * 0.8;
  double noOfSamples = 100;
  double get spacing => 4.10 * sW / Get.width;
  double get waveThickness => 2.0 * sW / Get.width;

  @override
  void initState() {
    super.initState();
    playerCtr = PlayerController();
    _preparePlayer();
  }

  Future<void> _preparePlayer() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final tempDir = await getTemporaryDirectory();
      File audioFile;

      // 选择要加载的音频文件
      // const bool useMp3 = false; // 设置为 true 使用 MP3，false 使用 PCM
      // 使用 MP3 文件
      // audioFile = File('${tempDir.path}/20250530095317.mp3');
      // if (!await audioFile.exists()) {
      //   final byteData = await rootBundle.load('assets/20250530095317.mp3');
      //   await audioFile.writeAsBytes(byteData.buffer.asUint8List());
      // }

      // 使用 PCM 文件（需要转换为 WAV）
      audioFile = await _convertPcmToWav(tempDir);

      _audioPath = audioFile.path;

      await playerCtr.preparePlayer(
        path: _audioPath!,
        shouldExtractWaveform: true,
        noOfSamples: noOfSamples.toInt(),
      );
      listenPlayerProgress();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to prepare audio: $e';
      });
      print('Error preparing audio: $e');
    }
  }

  @override
  void dispose() {
    playerCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('===== sW: $sW');
    // spacing = (sW - noOfSamples * waveThickness) / (noOfSamples - 1);
    print('===== spacing: $spacing');
    // if (spacing < waveThickness) {
    //   spacing = waveThickness + 0.1;
    // }
    print('===== spacing: $spacing');
    return Scaffold(
      appBar: AppBar(title: const Text("Audio Waveform Demo")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isLoading)
            const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading audio...'),
                ],
              ),
            )
          else if (_errorMessage != null)
            Center(
              child: Column(
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _preparePlayer,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          else ...[
            // 🎵 波形图
            AudioFileWaveforms(
              size: Size(sW, 100),
              playerController: playerCtr,
              enableSeekGesture: true,
              waveformType: WaveformType.fitWidth,
              playerWaveStyle: PlayerWaveStyle(
                fixedWaveColor: Colors.black.xsAlpha(0.30),
                liveWaveColor: Colors.red.xsAlpha(0.80),
                waveThickness: waveThickness,
                seekLineThickness: 5.0,
                spacing: spacing,
              ),
              onDragStart: (details) {
                print(
                    '===== onDragStart: ${details.localPosition} ${details.globalPosition}');
              },
              dragUpdateDetails: (details) {
                print(
                    '===== onDragUpdate: ${details.localPosition} ${details.globalPosition}');
              },
              onDragEnd: (details) {
                print(
                    '===== onDragEnd: ${details.localPosition} ${details.globalPosition}');
              },
              tapUpUpdateDetails: (details) {
                // print(
                //     '===== onTapUpUpdateDetails: ${details.localPosition} ${details.globalPosition}');
              },
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                // ▶️ 播放按钮
                IconButton(
                  iconSize: 64,
                  icon:
                      Icon(_isPlaying ? Icons.pause_circle : Icons.play_circle),
                  onPressed: togglePlay,
                ),
                const SizedBox(width: 16),
                IconButton(
                  iconSize: 64,
                  icon: const Icon(Icons.next_plan),
                  onPressed: skipForward15s,
                ),
              ],
            )
          ],
        ],
      ),
    );
  }
}

extension WaveformPagelogic on WaveformPageState {
  /// 将 PCM 文件转换为 WAV 格式
  Future<File> _convertPcmToWav(Directory tempDir) async {
    // 从 assets 加载 PCM 数据
    final pcmData = await rootBundle.load('assets/tone_10s_16k_mono_int16.pcm');
    final pcmBytes = pcmData.buffer.asUint8List();

    // WAV 文件参数（需要根据你的 PCM 文件调整）
    const int sampleRate = 16000; // 采样率
    const int channels = 1; // 声道数（1=单声道，2=立体声）
    const int bitsPerSample = 16; // 位深度

    // 创建 WAV 文件头
    final wavHeader = _createWavHeader(
      pcmBytes.length,
      sampleRate,
      channels,
      bitsPerSample,
    );

    // 合并 WAV 头和数据
    final wavBytes = Uint8List.fromList([
      ...wavHeader,
      ...pcmBytes,
    ]);

    // 保存为 WAV 文件
    final wavFile = File('${tempDir.path}/tone_10s_16k_mono_int16.wav');
    await wavFile.writeAsBytes(wavBytes);

    return wavFile;
  }

  /// 创建 WAV 文件头
  Uint8List _createWavHeader(
      int dataLength, int sampleRate, int channels, int bitsPerSample) {
    final byteRate = sampleRate * channels * bitsPerSample ~/ 8;
    final blockAlign = channels * bitsPerSample ~/ 8;
    final totalLength = 36 + dataLength;

    final header = ByteData(44);

    // RIFF header
    header.setUint8(0, 0x52); // 'R'
    header.setUint8(1, 0x49); // 'I'
    header.setUint8(2, 0x46); // 'F'
    header.setUint8(3, 0x46); // 'F'
    header.setUint32(4, totalLength, Endian.little);

    // WAVE format
    header.setUint8(8, 0x57); // 'W'
    header.setUint8(9, 0x41); // 'A'
    header.setUint8(10, 0x56); // 'V'
    header.setUint8(11, 0x45); // 'E'

    // fmt chunk
    header.setUint8(12, 0x66); // 'f'
    header.setUint8(13, 0x6D); // 'm'
    header.setUint8(14, 0x74); // 't'
    header.setUint8(15, 0x20); // ' '
    header.setUint32(16, 16, Endian.little); // fmt chunk size
    header.setUint16(20, 1, Endian.little); // audio format (PCM)
    header.setUint16(22, channels, Endian.little);
    header.setUint32(24, sampleRate, Endian.little);
    header.setUint32(28, byteRate, Endian.little);
    header.setUint16(32, blockAlign, Endian.little);
    header.setUint16(34, bitsPerSample, Endian.little);

    // data chunk
    header.setUint8(36, 0x64); // 'd'
    header.setUint8(37, 0x61); // 'a'
    header.setUint8(38, 0x74); // 't'
    header.setUint8(39, 0x61); // 'a'
    header.setUint32(40, dataLength, Endian.little);

    return header.buffer.asUint8List();
  }

  listenPlayerProgress() {
    playerCtr.onCurrentDurationChanged.listen((duration) {
      print('===== duration: $duration');
    });
  }

  void togglePlay() async {
    if (_audioPath == null) return;

    try {
      if (_isPlaying) {
        await playerCtr.pausePlayer();
      } else {
        await playerCtr.startPlayer();
      }
      if (mounted) {
        setState(() {
          _isPlaying = !_isPlaying;
        });
      }
    } catch (e) {
      print('Error toggling playback: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Playback error: $e';
        });
      }
    }
  }

  void skipForward15s() async {
    // 获取当前播放进度（单位: 毫秒）
    int currentPos = await playerCtr.getDuration(DurationType.current);
    int targetPos = currentPos + 15000;
    print('===== currentPos: $currentPos');
    print('===== targetPos: $targetPos');
    int totalDuration = await playerCtr.getDuration();
    print('===== totalDuration: $totalDuration');
    if (targetPos > totalDuration) {
      targetPos = totalDuration;
    }
    await playerCtr.seekTo(targetPos);
  }
}
