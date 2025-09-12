import 'package:flutter/material.dart';
import 'package:flutter_demos/styles/main_screen_styles.dart';
import 'package:get/get.dart';

class MyDrawerAnimationPage extends StatefulWidget {
  const MyDrawerAnimationPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return MyDrawerAnimationPageState();
  }
}

class MyDrawerAnimationPageState extends State<MyDrawerAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drawer Animation')),
      body: const WaveformEditor(),
    );
  }
}

class WaveformEditor extends StatefulWidget {
  const WaveformEditor({super.key});

  @override
  State createState() => WaveformEditorState();
}

class WaveformEditorState extends State<WaveformEditor> {
  final ScrollController containerScrollCtr =
      ScrollController(initialScrollOffset: 200);
  final ScrollController cardScrollCtr =
      ScrollController(initialScrollOffset: 0);
  double _offset = 0.0; // 当前滚动位置的偏移量
  bool isDoingAdsorbing = false;
  bool isCanCardScroll = true;
  @override
  void initState() {
    super.initState();
    containerScrollCtr.addListener(() {
      setState(() {
        _offset = containerScrollCtr.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is OverscrollNotification &&
              scrollNotification.depth == 1 &&
              scrollNotification.overscroll < -5) {
            print("container---->收到子控件无法处理--->$scrollNotification");
            setState(() {
              isCanCardScroll = false;
            });
            return true;
          }
          if (scrollNotification is ScrollEndNotification) {
            print("container---->滚动停止");
            if (!isDoingAdsorbing) {
              _snapToClosest();
            }
          }
          if (scrollNotification is ScrollUpdateNotification) {
            if (scrollNotification.metrics.pixels >=
                scrollNotification.metrics.maxScrollExtent) {
              print("container---->已经滚动到底部");
            }
          }
          return true;
        },
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            physics: const ClampingScrollPhysics(),
          ),
          child: IgnorePointer(
            ignoring: false,
            child: SingleChildScrollView(
              controller: containerScrollCtr,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(color: Colors.red, height: 200, width: Get.width),
                  Container(
                    color: Colors.blue,
                    height:
                        Get.height - MainScreen.topSafeH - MainScreen.appBarH,
                    width: Get.width,
                    child: NotificationListener<ScrollNotification>(
                        onNotification: (cardNofify) {
                          if (cardNofify is OverscrollNotification) {
                            return false;
                          }
                          return true;
                        },
                        child: IgnorePointer(
                          ignoring: !isCanCardScroll,
                          child: SingleChildScrollView(
                            controller: cardScrollCtr,
                            child: Column(
                              children: [
                                Container(
                                    color: Colors.purple,
                                    height: 200,
                                    width: Get.width),
                                Container(
                                    color: Colors.green,
                                    height: 200,
                                    width: Get.width),
                                Container(
                                    color: Colors.purple,
                                    height: 200,
                                    width: Get.width),
                                Container(
                                    color: Colors.green,
                                    height: 200,
                                    width: Get.width),
                                Container(
                                    color: Colors.purple,
                                    height: 200,
                                    width: Get.width),
                                Container(
                                    color: Colors.green,
                                    height: 200,
                                    width: Get.width),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  List<double> snapPositions = [
    0.0,
    200.0,
  ];
  // 判断最接近的吸附位置
  void _snapToClosest() {
    double closestPosition = snapPositions.reduce((curr, next) =>
        (curr - _offset).abs() < (next - _offset).abs() ? curr : next);
    _scrollToPosition(closestPosition);
  }

  void _scrollToPosition(double position) async {
    print("scrollToPosition: $position");
    isDoingAdsorbing = true;
    await Future.delayed(const Duration(milliseconds: 100));
    await containerScrollCtr.animateTo(position,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    isDoingAdsorbing = false;
    setState(() {
      isCanCardScroll = position == 200;
    });
    print("scrollToPosition end");
  }
}
