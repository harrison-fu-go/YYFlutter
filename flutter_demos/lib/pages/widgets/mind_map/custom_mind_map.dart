import 'dart:math';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mind_map/mind_map.dart';

class CustomMindMap extends MindMap {
  final double? lineWidth;

  const CustomMindMap({
    super.key,
    required super.children,
    super.lineColor,
    super.componentWith,
    super.padding,
    super.dotRadius,
    super.dotColor,
    this.lineWidth,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    var dotP = dotPath ?? Path()
      ..addOval(Rect.fromCircle(center: Offset.zero, radius: 2));
    return CustomRenderBranchComponent(
        dotColor, lineColor, padding, dotRadius, componentWith, dotP, 1);
  }
}

class CustomRenderBranchComponent extends RenderBranchComponent {
  final double? lineWidth;

  CustomRenderBranchComponent(
    super.dotColor,
    super.lineColor,
    super.padding,
    super.dotRadius,
    super.componentWith,
    super.dotPath,
    this.lineWidth,
  );

  @override
  void performLayout() {
    double dy = 0;
    double maxChildWidth = 0;

    final double dotWidth = dotPath.getBounds().width;
    double horizontalGap = 0; // 点和文本之间的间距
    final double dotRadius = dotWidth / 2;
    final double dotCenterX = componentWith;

    for (var child = firstChild; child != null; child = childAfter(child)) {
      child.layout(constraints.loosen(), parentUsesSize: true);
      final childParentData = child.parentData! as BranchComponentParentData;

      // 子节点放在 dot 右边，留出 dot 半径 + 间距
      final leftInset = dotCenterX + dotRadius + horizontalGap;
      childParentData.offset = Offset(leftInset, dy);

      dy += child.size.height;
      maxChildWidth = math.max(maxChildWidth, child.size.width);
    }

    final totalWidth = dotCenterX + dotRadius + horizontalGap + maxChildWidth;
    final totalHeight = dy;
    size = constraints.constrain(Size(totalWidth, totalHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Paint linesPaint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth ?? 1
      ..style = PaintingStyle.stroke;
    final Paint dotsPaint = Paint()..color = dotColor;

    /// start
    if (childCount == 0) {
      return;
    }

    int childNumber = 0;

    double y = offset.dy;

    Offset? start, end;

    late Rect rect1, rect2;

    Path lines = Path();

    Path dots = Path();

    double maxHeight = 0;

    for (var child = firstChild; child != null; child = childAfter(child)) {
      final BranchComponentParentData childParentData =
          child.parentData! as BranchComponentParentData;
      var offset0 = Offset(
          dotPath.getBounds().width / 2 + childParentData.offset.dx + offset.dx,
          childParentData.offset.dy + offset.dy);
      context.paintChild(child, offset0);

      final centerY = y + child.size.height / 2;
      final dotCenter = Offset(componentWith + offset.dx, centerY);

      maxHeight = y + child.size.height;

      /// old is grapRadius
      var side = dotPath.getBounds().width * 2;

      if (childNumber == 0) {
        // first child
        start = dotCenter;
        rect1 = Rect.fromLTWH(graphPadding + offset.dx, centerY, side, side);
      } else if (childNumber == childCount - 1) {
        // last child
        end = dotCenter;
        rect2 =
            Rect.fromLTWH(graphPadding + offset.dx, centerY - side, side, side);
      } else {
        // middle child
        lines
          ..moveTo(graphPadding + offset.dx, centerY)
          ..lineTo(dotCenter.dx, dotCenter.dy);
      }

      dots.addPath(dotPath, dotCenter);

      y += child.size.height;
      childNumber++;
    }

    Path centerLine = Path();
    centerLine
      ..moveTo(offset.dx, (offset.dy + maxHeight) / 2)
      ..lineTo(offset.dx + 10, (offset.dy + maxHeight) / 2);
    context.canvas.drawPath(centerLine, linesPaint);

    if (start != null && end != null) {
      lines
        ..moveTo(start.dx, start.dy)
        ..arcTo(rect1, -pi / 2, -pi / 2, false)
        ..arcTo(rect2, -pi, -pi / 2, false)
        ..lineTo(end.dx, end.dy);
    } else {
      if (start != null) {
        lines
          ..moveTo(offset.dx + 10, (offset.dy + maxHeight) / 2)
          ..lineTo(start.dx, start.dy);
      }
    }
    context.canvas.drawPath(lines, linesPaint);
    // ..drawPath(dots, dotsPaint);
  }
}
