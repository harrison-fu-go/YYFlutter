import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/pages/widgets/audio_edit/audio_edit_animation_page.dart';
import 'package:flutter_demos/pages/widgets/audio_edit/audio_editor.dart';
import 'package:flutter_demos/pages/widgets/my_elevated_button.dart';
import 'package:flutter_demos/styles/my_colors.dart';
import 'package:flutter_demos/utils/pop_tool.dart';
import 'package:get/get.dart';

class AudioEditPage extends StatefulWidget {
  const AudioEditPage({super.key});

  @override
  State<AudioEditPage> createState() => _AudioEditPageState();
}

class _AudioEditPageState extends State<AudioEditPage> {
  double get sW => Get.width * 0.8;
  double noOfSamples = 100;
  double get spacing => 4.10 * sW / Get.width;
  double get waveThickness => 2.0 * sW / Get.width;
  bool showBreakEffect = false;
  List<double> bars = [];
  @override
  void initState() {
    super.initState();
    AudioEditor.to.prepareDefaultAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Audio Editor'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  AudioFileWaveforms(
                    size: Size(sW, 100),
                    playerController: AudioEditor.to.playerCtr,
                    enableSeekGesture: true,
                    waveformType: WaveformType.fitWidth,
                    playerWaveStyle: PlayerWaveStyle(
                      fixedWaveColor:
                          const Color.fromARGB(255, 3, 2, 2).xsAlpha(0.30),
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
                  if (showBreakEffect)
                    Positioned.fill(
                      child: WaveformBreakEffect(
                        bars: bars,
                        startIndex: 0,
                        endIndex: 25,
                        barWidth: 2,
                        barGap: 2,
                        maxHeight: 100,
                      ),
                    ),
                ],
              ),
            ),
            IElevatedButton(
                title: 'Test cut audio',
                onTap: (index) async {
                  PopLoading.show();
                  await Future.delayed(const Duration(seconds: 2));
                  // await AudioEditor.to.cutAudio(
                  //     inputPath: AudioEditor.to.inputPath,
                  //     startSec: 10,
                  //     endSec: 20);

                  PopLoading.hide();
                  setState(() {
                    showBreakEffect = true;
                    bars = AudioEditor.to.playerCtr.waveformData;
                  });
                }),
            const SizedBox(height: 140),
          ],
        ).paddingSymmetric(horizontal: 16));
  }
}
