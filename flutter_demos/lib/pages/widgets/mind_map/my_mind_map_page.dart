/* File: my_stateless_demo_page.dart
 * Created by GYGES.Harrison on 2025/9/4 at 17:49
 * Copyright © 2024 GYGES Limited.
 */

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';

import '../../../styles/main_screen_styles.dart';
import '../my_elevated_button.dart';
import 'custom_mind_map.dart';
import 'mind_map_model.dart';

class MindMapPage extends StatefulWidget {
  const MindMapPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MindMapPageState();
  }
}

class MindMapPageState extends State<MindMapPage>
    with TickerProviderStateMixin {
  late double scale;
  late TransformationController _transformationController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  double maxScale = 30.0;
  double minScale = 0.1;
  @override
  void initState() {
    super.initState();
    scale = 1.0;
    _transformationController =
        TransformationController(Matrix4.identity()..scale(1.0));

    // 初始化动画控制器
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // 监听动画值变化
    _scaleAnimation.addListener(() {
      _centerScale(_scaleAnimation.value);
    });
    _transformationController.addListener(() {
      scale = _transformationController.value.getMaxScaleOnAxis();
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _centerScale(double newScale) {
    // 获取当前变换矩阵
    final currentMatrix = _transformationController.value;

    // 获取当前缩放值
    final currentScale = currentMatrix.getMaxScaleOnAxis();

    // 如果缩放值没有变化，直接返回，避免抖动
    if ((newScale - currentScale).abs() < 0.01) {
      return;
    }

    // 计算缩放比例
    final scaleRatio = newScale / currentScale;

    // 获取当前变换的平移量
    final currentTranslation = currentMatrix.getTranslation();

    // 计算屏幕中心点
    final screenSize = MediaQuery.of(context).size;
    final screenCenterX = screenSize.width / 2;
    final screenCenterY = screenSize.height / 2;

    // 计算新的平移量，保持内容在屏幕中心
    final newTranslationX =
        screenCenterX - (screenCenterX - currentTranslation.x) * scaleRatio;
    final newTranslationY =
        screenCenterY - (screenCenterY - currentTranslation.y) * scaleRatio;

    // 创建新的变换矩阵
    final newMatrix = Matrix4.identity()
      ..translate(newTranslationX, newTranslationY)
      ..scale(newScale);

    _transformationController.value = newMatrix;
  }

  void _animateScale(double targetScale) {
    // 设置动画的起始值和结束值
    _scaleAnimation = Tween<double>(
      begin: scale,
      end: targetScale,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // 更新当前缩放值
    scale = targetScale;

    // 开始动画
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MainScreen.topSafeH),
          const SizedBox(width: 10),
          Row(
            children: [
              const SizedBox(width: 10),
              IElevatedButton(
                  title: '+',
                  onTap: (index) {
                    // 获取当前缩放值
                    double currentScale =
                        _transformationController.value.getMaxScaleOnAxis();
                    double targetScale = currentScale + 0.5;
                    if (targetScale > maxScale) {
                      targetScale = maxScale;
                    }
                    // 使用动画缩放
                    _animateScale(targetScale);
                  }),
              const SizedBox(width: 10),
              IElevatedButton(
                  title: '-',
                  onTap: (index) {
                    double currentScale =
                        _transformationController.value.getMaxScaleOnAxis();
                    double targetScale = currentScale - 0.5;
                    if (targetScale < minScale) {
                      targetScale = minScale;
                    }
                    // 使用动画缩放
                    _animateScale(targetScale);
                  }),
              const SizedBox(width: 10),
              IElevatedButton(
                  title: '旋转',
                  onTap: (index) {
                    print('旋转: $index');
                  }),
            ],
          ),
          Expanded(
            child: InteractiveViewer(
              maxScale: maxScale,
              minScale: minScale,
              constrained: false,
              boundaryMargin: const EdgeInsets.all(1000),
              transformationController: _transformationController,
              child: Container(
                color: Colors.transparent,
                width: MainScreen.screenW,
                height: MainScreen.screenH - 100,
                child: buildMindPoint(rootList),
              ),
            ),
          ),
        ],
      ),
    );
  }

  MindPoint buildMindPoint(MindMapModel model) {
    return MindPoint(
        title: model.title,
        titleStyle: model.titleStyle,
        maxTextWidth: model.maxTextWidth,
        height: model.height,
        componentWith: model.componentWith,
        lineColor: model.lineColor,
        children: buildSubMindPoints(model));
  }

  List<MindPoint> buildSubMindPoints(MindMapModel model) {
    return model.children?.map((e) => buildMindPoint(e)).toList() ?? [];
  }
}

class MindPoint extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final double? maxTextWidth;
  final double? height;
  final List<MindPoint>? children;
  final double? componentWith;
  final Color? lineColor;
  const MindPoint(
      {super.key,
      required this.title,
      this.maxTextWidth,
      this.height,
      this.children,
      this.titleStyle,
      this.componentWith,
      this.lineColor});
  @override
  State<MindPoint> createState() => MindPointState();
}

class MindPointState extends State<MindPoint> {
  late String title;
  TextStyle? titleStyle;
  double? width;
  double? height;
  late List<MindPoint> children;
  double? componentWith;
  Color? lineColor;
  @override
  void initState() {
    super.initState();
    title = widget.title;
    width = widget.maxTextWidth;
    height = widget.height;
    children = widget.children ?? [];
    titleStyle = widget.titleStyle;
    componentWith = widget.componentWith;
    lineColor = widget.lineColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstraintsText(text: title, maxWidth: width, textStyle: titleStyle)
              .paddingOnly(right: 4),
          if (children.isNotEmpty)
            MindMapListView(
                componentWith: componentWith,
                lineColor: lineColor,
                children: children),
        ],
      ),
    ).paddingSymmetric(vertical: 8);
  }
}

class MindMapListView extends StatefulWidget {
  final Color? lineColor;
  final double? componentWith;
  final EdgeInsets? padding;
  final List<MindPoint> children;
  const MindMapListView(
      {super.key,
      required this.children,
      this.lineColor,
      this.componentWith,
      this.padding});
  @override
  State<MindMapListView> createState() => MindMapListViewState();
}

class MindMapListViewState extends State<MindMapListView> {
  late Color lineColor;
  late double componentWith;
  late EdgeInsets padding;
  late List<MindPoint> children;

  @override
  void initState() {
    super.initState();
    lineColor = widget.lineColor ?? Colors.purple;
    componentWith = widget.componentWith ?? 50;
    padding = widget.padding ?? const EdgeInsets.only(right: 0);
    children = widget.children;
  }

  @override
  Widget build(BuildContext context) {
    return CustomMindMap(
        lineColor: lineColor,
        componentWith: componentWith,
        padding: padding,
        children: children);
  }
}

class ConstraintsText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final double? maxWidth;
  const ConstraintsText(
      {super.key, required this.text, this.maxWidth, this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? 80,
      ),
      child: Text(
        text,
        softWrap: true,
        overflow: TextOverflow.visible,
        style: textStyle ?? const TextStyle(fontSize: 8, color: Colors.black),
      ),
    );
  }
}
