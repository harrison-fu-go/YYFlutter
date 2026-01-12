import 'dart:async';
import 'dart:math';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioCustomWaveForms extends StatefulWidget {
  const AudioCustomWaveForms(
      {super.key, required this.controller, required this.waveformData});
  final PlayerController controller;
  final List<double> waveformData;
  @override
  State<AudioCustomWaveForms> createState() => _AudioCustomWaveFormsState();
}

class _AudioCustomWaveFormsState extends State<AudioCustomWaveForms> {
  List<double> waveformData = [];
  StreamSubscription<List<double>>? extractedWaveStream;
  double progress = 0;
  bool isPlaying = false;
  final ValueNotifier<Set<int>> shatteredBarsNotifier =
      ValueNotifier<Set<int>>({});
  @override
  void initState() {
    super.initState();
    waveformData = widget.waveformData;
    extractedWaveStream =
        widget.controller.onCurrentExtractedWaveformData.listen((waveData) {
      setState(() {
        waveformData = List.from(waveData);
      });
    });
    widget.controller.onCurrentDurationChanged.listen((duration) {
      var tempProgress = duration / widget.controller.maxDuration;
      setState(() {
        progress = tempProgress;
      });
    });
    widget.controller.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    // Future.delayed(const Duration(seconds: 5), () {
    //   widget.controller.startPlayer();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: Get.width,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < waveformData.length; i++)
            _WaveformBarItem(
              key: ValueKey(i),
              index: i,
              height: waveformData[i] * 200,
              isPlaying:
                  isPlaying && (i <= (progress * waveformData.length).toInt()),
              shatteredBarsNotifier: shatteredBarsNotifier,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    extractedWaveStream?.cancel();
    shatteredBarsNotifier.dispose();
    super.dispose();
  }
}

class _WaveformBarItem extends StatelessWidget {
  const _WaveformBarItem({
    super.key,
    required this.index,
    required this.height,
    required this.isPlaying,
    required this.shatteredBarsNotifier,
  });

  final int index;
  final double height;
  final bool isPlaying;
  final ValueNotifier<Set<int>> shatteredBarsNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<int>>(
      valueListenable: shatteredBarsNotifier,
      builder: (context, shatteredBars, child) {
        return shatteredBars.contains(index)
            ? ShatterBar(
                key: ValueKey('shatter_$index'),
                originalHeight: height,
              )
            : WaveformBar(
                key: ValueKey('wave_$index'),
                height: height,
                isPlaying: isPlaying,
              );
      },
    );
  }
}

class WaveformBar extends StatefulWidget {
  const WaveformBar({super.key, required this.height, required this.isPlaying});
  final double height;
  final bool isPlaying;
  @override
  State<WaveformBar> createState() => _WaveformBarState();
}

class _WaveformBarState extends State<WaveformBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: widget.height).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(WaveformBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.height != widget.height) {
      _animation = Tween<double>(begin: 0.0, end: widget.height).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 1,
          height: _animation.value,
          decoration: BoxDecoration(
            color: widget.isPlaying ? Colors.red : Colors.black,
            borderRadius: BorderRadius.circular(1),
          ),
        );
      },
    );
  }
}

class ShatterBar extends StatefulWidget {
  final double originalHeight;
  const ShatterBar({super.key, required this.originalHeight});

  @override
  State<ShatterBar> createState() => _ShatterBarState();
}

class _ShatterBarState extends State<ShatterBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Fragment> fragments;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // 创建碎片
    fragments = List.generate(min(12, widget.originalHeight.toInt()), (i) {
      return _Fragment(
        // 随机水平偏移（飘落）
        dx: (i - 3) * 4.0 + (i % 2 == 0 ? 5 : -5),
        // 随机下落速度
        dy: 10 + i * 8,
        // 随机旋转
        rotation: (i.isEven ? 1 : -1) * 0.6,
        // 每块碎片高度
        height: widget.originalHeight / 12,
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1,
      height: widget.originalHeight,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          final t = _controller.value;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              for (int i = 0; i < fragments.length; i++)
                Transform.translate(
                  offset: Offset(
                    fragments[i].dx * t,
                    fragments[i].dy * t * 3,
                  ),
                  child: Transform.rotate(
                    angle: fragments[i].rotation * t * 3,
                    child: Opacity(
                      opacity: (1 - t).clamp(0, 1),
                      child: Container(
                        width: 2,
                        height: fragments[i].height / 3,
                        margin: EdgeInsets.only(
                            top: fragments[i].height * i.toDouble()),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Fragment {
  final double dx;
  final double dy;
  final double rotation;
  final double height;

  _Fragment({
    required this.dx,
    required this.dy,
    required this.rotation,
    required this.height,
  });
}
