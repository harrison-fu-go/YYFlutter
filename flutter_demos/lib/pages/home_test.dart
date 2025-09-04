/* File: home_test.dart
 * Created by GYGES.Harrison on 2024/11/13 at 17:31
 * Copyright © 2024 GYGES Limited.
 */
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_demos/TexsSpans/custom_text_span.dart';
import 'package:flutter_demos/crypt/sha_256.dart';
import 'package:flutter_demos/dio/dio_request.dart';
import 'package:flutter_demos/dio/download/download_service.dart';
import 'package:flutter_demos/system_info/app_info.dart';
import 'package:flutter_demos/system_info/device_info.dart';
import 'package:get/get.dart';
import 'package:gyges_logger/gyges_logger.dart';
import '../TexsSpans/cus_text_icon_span.dart';
import '../getX/get_x_controller.dart';
import '../strings/string_util.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 创建控制器的实例
  final CounterController counterControl = Get.put(CounterController());

  void _incrementCounter() {
    counterControl.increment(); // 调用控制器的方法
  }

  double downloadProgress = 0.0;
  bool downloadFinished = false;

  Future<void> test() async {

  }
  @override
  void initState() {
    super.initState();
    DioRequest.setUp();
    test();
    // String original = "即风刀霜dddddabcdefg";
    // String limited = limitToByteLen(original, 3);
    // print("Original: $original");
    // print("Limited: $limited");
    // print("Original Bytes: ${utf8.encode(original).length}");
    // print("Limited Bytes: ${utf8.encode(limited).length}");
    //
    // for (int index = 1; index <= utf8.encode(original).length; index ++) {
    //   String decodeList = utf8.encode(original).toStrByRange(start: 0, end: index);
    //   print('result: ==== $decodeList');
    // }

    List<int> datas = [
      2,
      9,
      230,
      136,
      145,
      230,
      136,
      145,
      230,
      136,
      145,
      9,
      228,
      189,
      160,
      228,
      189,
      160,
      228,
      189,
      160,
      0,
      1,
      15,
      99,
      111,
      109,
      46,
      97,
      110,
      100,
      114,
      111,
      105,
      100,
      46,
      109,
      109,
      115,
      1,
      2,
      3,
      49,
      49,
      49,
      2,
      49,
      50,
      1,
      6,
      230,
      157,
      142,
      229,
      155,
      155,
      1,
      3,
      50,
      50,
      50,
      1,
      3,
      51,
      51,
      51
    ];
    var value = datas.getAll8nStrs(start: 0);
    print('result: ==== $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: "搜索"),
      //   ],
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              // 使用 Obx 监听状态变化并更新 UI
              child: Obx(() =>
                  Text(
                    'Clicked ${counterControl.count} times',
                    style: const TextStyle(fontSize: 30),
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/second'); // 导航到第二个页面
              },
              child: Text('Go to Second Page'),
            ),
            ElevatedButton(
              onPressed: () async {
                String ostype = await XsDeviceInfo.shared.osType;
                String osVersion = await XsDeviceInfo.shared.osVersion;
                String buildNumber = await XsAppInfo.shared.appVersioncode;
                String appVersion = await XsAppInfo.shared.appVersionName;
                print('==========device info: ${(ostype, osVersion)}');
                print('==========device info: ${(buildNumber, appVersion)}');
              },
              child: Text('打印设备相关信息'),
            ),
            const SizedBox(
              height: 32,
            ),
            RichTextWithIcon(
              spanModels: [
                TextSpanModel(isIcon: true,
                    iNeedTap: true,
                    style: const TextStyle(height: 40)),
                TextSpanModel(
                    text: 'hellodd-----jfjslkdfjsldfjslfjs fdjslkfjsklfjdslfkjs fdsjfkjdkfs fdskfjskfj'),
                TextSpanModel(text: 'helllllll')
              ],
              onTapCallback: (val) {
                print('==========RichTextWithIcon info: $val');
              },
            ),
            ElevatedButton(
              onPressed: () async {
                String sha256_1 = hmac(map: {
                  'a': [
                    2,
                    3,
                    4,
                    5,
                    {'a': 1, 'b': 2, 'a1': 3}
                  ],
                  'aa': 124,
                  'bb': {'key0': 34, 'key1': 45, 'aa': 66},
                  'ab': 'addd,fdhsfjdslfjskljfslfjdslfks,lfjsk'
                }, hmacKey: '234');
                String sha256_2 = hmac(map: {
                  'ab': 'addd,fdhsfjdslfjskljfslfjdslfks,lfjsk',
                  'aa': 124,
                  'a': [
                    2,
                    3,
                    4,
                    5,
                    {'a': 1, 'b': 2, 'a1': 3}
                  ],
                  'bb': {'aa': 66, 'key0': 34, 'key1': 45},
                }, hmacKey: '234');
                print('========计算sha256结果 $sha256_1  ==== $sha256_2');
              },
              child: const Text('计算sha-256'),
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                // DioRequest.request();
                DownloadService.to.downloadFile(
                    url: 'http://192.168.1.200/stage-api/file/download?key=02a74e23b7ee4438955c0ee2dbd3267c',
                    filename: 'test.temp',
                    checkSum: 3181562676,
                    progressHandle: (progress) {
                      setState(() {
                        downloadProgress = progress;
                      });
                    },
                    completionHandle: (success, mess) {
                      print('下载文件completion: $success, --> mess: $mess');
                    });
              },
              child: Text('  开始下载 -> $downloadProgress'),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                // DioRequest.request();
                DownloadService.to.pauseDownload();
              },
              child: const Text('停止下载'),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                // DioRequest.request();
                DownloadService.to.removeFile('test.temp');
              },
              child: const Text('清除下载文件'),
            ),
            ElevatedButton(
              onPressed: () {
                // DioRequest.request();
                DownloadService.to.calculateCheckSum(filename: 'test.temp');
              },
              child: const Text('计算checkSum'),
            ),
            ElevatedButton(
              onPressed: () {
                showBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      color: Colors.blueAccent,
                      child: Center(
                        child: Text("Bottom Sheet 内容"),
                      ),
                    );
                  },
                );
              },
              child: const Text('弹出框'),
            ),
            const XsCusTextSpan(
              textInfos: [
                ('dsfsfsfsfs', TextStyle(fontSize: 20), link: null),
                ('dsfsfsfsfsdddd', null, link: null),
              ],
              defaultHighlightStyle: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
