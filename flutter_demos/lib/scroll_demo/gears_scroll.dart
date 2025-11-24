import 'package:flutter/material.dart';

class SlotSlider extends StatefulWidget {
  const SlotSlider({super.key});
  @override
  _SlotSliderState createState() => _SlotSliderState();
}

class _SlotSliderState extends State<SlotSlider> {
  double _value = 0.5;
  final List<double> _slots = [0.0, 0.25, 0.5, 0.75, 1.0];

  // 查找最接近的档位
  double _findNearestSlot(double value) {
    return _slots
        .reduce((a, b) => (value - a).abs() < (value - b).abs() ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    Color selColor = Colors.black;
    Color norColor = const Color.fromARGB(255, 0xEC, 0xEC, 0xEC);
    return GestureDetector(
      onPanUpdate: (details) {
        _value += -details.delta.dy / 200; // 控制滑动速度
        setState(() {
          _value = _value.clamp(0.0, 1.0);
        });
      },
      onPanEnd: (_) {
        setState(() {
          print('-----> value: $_value');
        });
      },
      child: Container(
        height: 200,
        width: 40,
        color: Colors.transparent,
        child: Stack(
          children: [
            progressCell(top: 0, color: _value >= 0.9 ? selColor : norColor),
            progressCell(top: 4 + 30, color: _value >= 0.8 ? selColor : norColor),
            progressCell(top: 4 + 30 + 4 + 30, color: _value >= 0.6 ? selColor : norColor),
            progressCell(top: 4 + 30 + 4 + 30 + 4 + 30, color: _value >= 0.4 ? selColor : norColor),
            progressCell(top: 4 + 30 + 4 + 30 + 4 + 30 + 4 + 30, color: _value >= 0.2 ? selColor : norColor),
            progressCell(top: 4 + 30 + 4 + 30 + 4 + 30 + 4 + 30 + 4 + 30, color:  selColor),
          ],
        ),
      ),
    );
  }

  Widget progressCell({required double top, required Color color}) {
    return Positioned(
      top: top,
      left: 0,
      child: Container(
        width: 40,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

  }

}
