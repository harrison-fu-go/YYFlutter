import 'package:flutter/material.dart';

class VerticalLineWithDots extends StatelessWidget {
  final double height;
  final double lineWidth;
  final Color lineColor;
  final double dotRadius;
  final Color dotColor;
  final MainAxisAlignment
      alignment; // 可选： MainAxisAlignment.center / start / end

  const VerticalLineWithDots({
    super.key,
    this.height = 120,
    this.lineWidth = 2,
    this.lineColor = Colors.black,
    this.dotRadius = 6,
    this.dotColor = Colors.black,
    this.alignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final dotSize = dotRadius * 2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      children: [
        // top dot
        Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),

        // line
        Container(
          width: lineWidth,
          height: height - dotSize * 2,
          color: lineColor,
        ),
        // bottom dot
        Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
