/* File: home_test1.dart
 * Created by GYGES.Harrison on 2024/11/13 at 17:50
 * Copyright © 2024 GYGES Limited.
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../scroll_demo/scroll_content.dart';

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("测试2"),
      ),
      body: Column(children: [
        ElevatedButton(
          onPressed: () {
            double sH = MediaQuery.of(context).size.height;
            double bottomH = MediaQuery.of(context).padding.bottom;
            double bottomSafeH = 34; //MediaQuery.of(context).padding.bottom;
            Scaffold.of(context).showBottomSheet(
              enableDrag: false, // 禁用拖动关闭
              backgroundColor: Colors.transparent,
              (BuildContext context) {
                return OverflowBox(
                  maxHeight:
                      MediaQuery.of(context).size.height * 1.5, // 设置超出屏幕的高度
                  alignment: Alignment.topCenter, // 对齐方式
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height:
                          MediaQuery.of(context).size.height * 1.0, // 比屏幕高度稍大
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha((0.2 * 255).toInt()),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: sH - bottomSafeH - bottomH - 20 - 40),
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              color: Colors.yellow,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("关闭"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: Text("显示底部弹框"),
        ),
        ElevatedButton(
            onPressed: () {
              showFlutterToast();
            },
            child: const Text('Show flutter toast')),
        Container(height: 300, width: 300, child: const ScrollContentDemo())
      ]),
    );
  }

  void showFlutterToast() {
    Fluttertoast.showToast(
      msg: "Ring Version 3.1.0 is available to your glasses",
      toastLength: Toast.LENGTH_LONG, // 显示时长
      timeInSecForIosWeb: 5,
      gravity: ToastGravity.TOP, // 显示位置
      backgroundColor: const Color.fromARGB(0xFF, 0xD9, 0xD9, 0xD9),
      textColor: const Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
      fontSize: 12.0,
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Text('This is a custom bottom sheet'),
      ),
    );
  }
}
