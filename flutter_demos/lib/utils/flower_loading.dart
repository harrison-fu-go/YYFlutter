import 'package:flutter/widgets.dart';

class FlowerLoading extends StatefulWidget {
  final double? size;
  final String? title;
  final bool? useGradients;
  final Widget? customIcon;
  final bool? isNeedRotation;
  const FlowerLoading({
    super.key,
    this.size,
    this.title,
    this.useGradients,
    this.customIcon,
    this.isNeedRotation = true,
  });

  @override
  State<FlowerLoading> createState() => _FlowerLoadingState();
}

class _FlowerLoadingState extends State<FlowerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isNeedRotation = true;
  @override
  void initState() {
    super.initState();
    isNeedRotation = widget.isNeedRotation ?? true;
    //init AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); //repeat animation.
  }

  @override
  Widget build(BuildContext context) {
    String img = widget.useGradients == true
        ? 'flower_loading_gradients'
        : 'flower_loading_gradients';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isNeedRotation
            ? RotationTransition(
                turns: _controller,
                child: widget.customIcon ??
                    Image.asset('assets/images/$img.png',
                        width: widget.size ?? 32, height: widget.size ?? 32),
              )
            : widget.customIcon ??
                Image.asset('assets/images/$img.png',
                    width: widget.size ?? 32, height: widget.size ?? 32),
        if (widget.title != null) const SizedBox(height: 10),
        widget.title != null
            ? Text(widget.title ?? '', style: const TextStyle(fontSize: 14))
            : const SizedBox()
      ],
    );
  }

  @override
  void didUpdateWidget(covariant FlowerLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isNeedRotation != widget.isNeedRotation) {
      isNeedRotation = widget.isNeedRotation ?? true;
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // dispose AnimationController
    super.dispose();
  }
}
