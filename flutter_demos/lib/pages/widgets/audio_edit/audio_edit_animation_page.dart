import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_demos/styles/my_colors.dart';

class WaveformBreakEffect extends StatefulWidget {
  final List<double> bars; // 每根波形条的高度，例如 [10,20,13,18]
  final int startIndex; // 裁剪的开始索引
  final int endIndex; // 裁剪的结束索引
  final double barWidth;
  final double barGap;
  final double maxHeight;
  final Duration duration;

  const WaveformBreakEffect({
    super.key,
    required this.bars,
    required this.startIndex,
    required this.endIndex,
    this.barWidth = 4,
    this.barGap = 2,
    this.maxHeight = 120,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  State<WaveformBreakEffect> createState() => _WaveformBreakEffectState();
}

class _WaveformBreakEffectState extends State<WaveformBreakEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final List<_Particle> particles = [];
  final Random rnd = Random();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _generateParticles();
    controller.forward();
  }

  void _generateParticles() {
    for (int i = widget.startIndex; i <= widget.endIndex; i++) {
      double height = widget.bars[i];

      // 为每根 bar 生成随机小碎片
      int count = 12;
      for (int j = 0; j < count; j++) {
        double pieceX = i * (widget.barWidth + widget.barGap);
        double pieceY = widget.maxHeight - (height * rnd.nextDouble());

        particles.add(
          _Particle(
            x: pieceX,
            y: pieceY,
            size: 2 + rnd.nextDouble() * 4,
            vx: (rnd.nextDouble() - 0.5) * 40, // 随机左右飞散
            vy: 40 + rnd.nextDouble() * 90, // 向下坠落
            rotation: rnd.nextDouble() * 1.5,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => CustomPaint(
        size: Size(double.infinity, widget.maxHeight),
        painter: _WaveformBreakPainter(
          progress: controller.value,
          particles: particles,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _Particle {
  double x, y;
  double size;
  double vx, vy;
  double rotation;
  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.vx,
    required this.vy,
    required this.rotation,
  });
}

class _WaveformBreakPainter extends CustomPainter {
  final double progress;
  final List<_Particle> particles;

  _WaveformBreakPainter({
    required this.progress,
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          const Color.fromARGB(255, 3, 2, 2).xsAlpha(0.30 * (1 - progress));

    for (final p in particles) {
      final x = p.x + p.vx * progress;
      final y = p.y + p.vy * progress;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.rotation * progress);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformBreakPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
