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
      body: const DrawerAnimationPage(),
    );
  }
}

class DrawerAnimationPage extends StatefulWidget {
  const DrawerAnimationPage({super.key});

  @override
  State createState() => DrawerAnimationPageState();
}

class DrawerAnimationPageState extends State<DrawerAnimationPage> {
  final ScrollController containerScrollCtr =
      ScrollController(initialScrollOffset: 200);
  final ScrollController cardScrollCtr =
      ScrollController(initialScrollOffset: 0);

  double _offset = 0.0; // 当前滚动位置的偏移量
  bool isDoingAdsorbing = false;
  int overscrollCount = 0;
  bool isCanSubScroll = true;

  @override
  void initState() {
    super.initState();
    containerScrollCtr.addListener(() {
      setState(() {
        _offset = containerScrollCtr.offset;
      });
    });
    cardScrollCtr.addListener(() {
      if (containerScrollCtr.offset < 200) {
        cardScrollCtr.jumpTo(0);
        if (isCanSubScroll) {
          setState(() {
            isCanSubScroll = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          // if (scrollNotification is OverscrollNotification &&
          //     scrollNotification.depth == 1 &&
          //     scrollNotification.overscroll < 0) {
          //   print("container---->收到子控件无法处理--->$scrollNotification");
          //   // 手动触发父控件滚动，模拟继续当前手势
          //   _handleParentScroll(scrollNotification.overscroll);
          //   return true; // 让通知继续传播
          // }
          if (scrollNotification is ScrollEndNotification) {
            print("container---->滚动停止-> $overscrollCount");
            if (!isDoingAdsorbing && overscrollCount == 0) {
              _snapToClosest();
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
                      onNotification: (subScrollNotification) {
                        print("sub--> $subScrollNotification");
                        if (subScrollNotification is OverscrollNotification) {
                          // 让 OverscrollNotification 向上传播到父控件
                          print("sub--> 子控件发生过度滚动，传播给父控件");
                          _handleParentScroll(subScrollNotification.overscroll);
                          return true;
                        }
                        if (subScrollNotification is ScrollEndNotification) {
                          overscrollCount = 0;
                          _snapToClosest();
                        }
                        return true;
                      },
                      child: IgnorePointer(
                        ignoring: !isCanSubScroll,
                        child: SingleChildScrollView(
                          controller: cardScrollCtr,
                          child: Column(
                            children: [
                              Container(
                                color: Colors.purple,
                                height: 200,
                                width: Get.width,
                                child: const Text('1dfsdfds...'),
                              ),
                              Container(
                                  color: Colors.green,
                                  height: 200,
                                  width: Get.width),
                              Container(
                                  color: Colors.purple,
                                  height: 200,
                                  width: Get.width),
                              Container(
                                  color: Colors.yellow,
                                  height: 400,
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
                                width: Get.width,
                                child: const Text('This is the end'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
    setState(() {
      isCanSubScroll = position == 200;
    });
    isDoingAdsorbing = false;
    print("scrollToPosition end");
  }

  // 处理父控件滚动，接管子控件的过度滚动
  void _handleParentScroll(double overscroll) {
    // 将子控件的过度滚动量转换为父控件的滚动
    double newOffset = containerScrollCtr.offset + (overscroll * 0.5);
    print("父控件接管滚动，overscroll: $overscroll-->newOffset: $newOffset");
    // 确保不超出父控件的滚动范围
    if (newOffset < containerScrollCtr.position.maxScrollExtent) {
      overscrollCount = overscrollCount + 1;
      containerScrollCtr.jumpTo(newOffset);
    }
  }
}
