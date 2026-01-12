import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demos/pages/base/confirm_exit_view.dart';
import 'package:flutter_demos/pages/widgets/audio_edit/audio_custom_wave_forms.dart';
import 'package:flutter_demos/pages/widgets/audio_edit/audio_editor.dart';
import 'package:flutter_demos/pages/widgets/audio_edit/sub_views/control_line.dart';
import 'package:flutter_demos/styles/my_colors.dart';
import 'package:get/get.dart';

class AudioEditPage extends StatefulWidget {
  const AudioEditPage({super.key});

  @override
  State<AudioEditPage> createState() => _AudioEditPageState();
}

enum ControlLine {
  left,
  right,
  control,
  none,
}

const double paddingX = 16;
const double dotRadius = 3;
const double chartH = 200;

class _AudioEditPageState extends State<AudioEditPage> {
  List<double> bars = [];
  ControlLine currentControlLine = ControlLine.control;
  double waveWidth = Get.width - 2 * 16;
  double leftControlX = paddingX;
  double rightControlX = paddingX;
  @override
  void initState() {
    super.initState();
    prepareAudio();
  }

  void prepareAudio() async {
    await AudioEditor.to.prepareDefaultAudio();
  }

  @override
  Widget build(BuildContext context) {
    return ConfirmExitView(
        onPop: () {
          Get.back();
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Audio Editor'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AudioCustomWaveForms(
                        controller: AudioEditor.to.playerCtr,
                        waveformData: bars,
                      ).paddingSymmetric(horizontal: paddingX),
                      Positioned(
                        top: -dotRadius * 2,
                        left: leftControlX - dotRadius,
                        child: const VerticalLineWithDots(
                            height: chartH + dotRadius * 4,
                            lineWidth: 1,
                            lineColor: Colors.red,
                            dotRadius: dotRadius,
                            dotColor: Colors.red),
                      ),
                      Positioned(
                        top: 0,
                        left: leftControlX,
                        right: rightControlX,
                        bottom: 0,
                        child: Container(
                          color: Colors.yellow.xsAlpha(0.2),
                          height: 200,
                        ),
                      ),
                      Positioned(
                        top: -6,
                        right: rightControlX - dotRadius,
                        child: const VerticalLineWithDots(
                            height: chartH + dotRadius * 4,
                            lineWidth: 1,
                            lineColor: Colors.red,
                            dotRadius: dotRadius,
                            dotColor: Colors.red),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTapDown: (details) {
                            calculateControlLine(details.localPosition.dx);
                          },
                          onTapUp: (details) {
                            print('===== onTapUp: $details');
                          },
                          onTap: () {
                            print('===== onTap: ');
                          },
                          onHorizontalDragStart: (details) {
                            calculateControlLine(details.localPosition.dx);
                            print(
                                '===== onHorizontalDragStart: ${details.localPosition.dx}');
                          },
                          onHorizontalDragUpdate: (details) {
                            updateMoveX(details);
                            print(
                                '===== onHorizontalDragUpdate: ${details.localPosition.dx}');
                          },
                          onHorizontalDragEnd: (details) {
                            currentControlLine = ControlLine.none;
                            print(
                                '===== onHorizontalDragEnd: ${details.localPosition.dx}');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 140),
              ],
            )));
  }

  updateMoveX(DragUpdateDetails details) {
    double x = details.localPosition.dx;
    if (x < 0) {
      x = 0;
    }
    if (x > waveWidth) {
      x = waveWidth;
    }
    if (currentControlLine == ControlLine.left) {
      setState(() {
        leftControlX = x;
      });
    } else if (currentControlLine == ControlLine.right) {
      setState(() {
        rightControlX = waveWidth - x;
      });
    }
  }

  calculateControlLine(double dx) {
    double x = dx;
    if (x < 0) {
      x = 0;
    }
    if (x > waveWidth) {
      x = waveWidth;
    }
    double dL = (x - leftControlX).abs();
    double dR = (x - (waveWidth - rightControlX)).abs();
    double minValue = min(dL, dR);
    if (minValue > 50) {
      currentControlLine = ControlLine.control;
      return;
    }
    if (dL < dR) {
      currentControlLine = ControlLine.left;
    } else {
      currentControlLine = ControlLine.right;
    }
  }
}
