/* File: home_test.dart
 * Created by GYGES.Harrison on 2024/11/13 at 17:31
 * Copyright © 2024 GYGES Limited.
 */
import 'package:flutter/material.dart';
import 'package:flutter_demos/TexsSpans/custom_text_span.dart';
import 'package:flutter_demos/crypt/sha_256.dart';
import 'package:flutter_demos/dio/dio_request.dart';
import 'package:flutter_demos/dio/download/download_service.dart';
import 'package:flutter_demos/http_link/open_link.dart';
import 'package:flutter_demos/system_info/app_info.dart';
import 'package:flutter_demos/system_info/device_info.dart';
import 'package:get/get.dart';
import 'package:gyges_logger/gyges_logger.dart';
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

  Future<void> test() async {}
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
        backgroundColor: Colors.red.withAlpha(188),
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              String ostype = XsDeviceInfo.shared.osType;
              String osVersion = await XsDeviceInfo.shared.osVersion;
              String buildNumber = await XsAppInfo.shared.appVersioncode;
              String appVersion = await XsAppInfo.shared.appVersionName;
              print('==========device info: ${(ostype, osVersion)}');
              print('==========device info: ${(buildNumber, appVersion)}');
            },
            child: const Text('打印设备相关信息'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              String sha256_1 = demoHmac0();
              String sha256_2 = demoHmac1();
              print('========> 计算sha256结果 $sha256_1  ==== $sha256_2');
            },
            child: const Text('计算sha-256'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // DioRequest.request();
              DownloadService.to.downloadFile(
                  url:
                      'http://192.168.1.200/stage-api/file/download?key=02a74e23b7ee4438955c0ee2dbd3267c',
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
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // DioRequest.request();
              DownloadService.to.removeFile('test.temp');
            },
            child: const Text('清除下载文件'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // DioRequest.request();
              DownloadService.to.calculateCheckSum(filename: 'test.temp');
            },
            child: const Text('计算checkSum'),
          ),
          const SizedBox(height: 8),
          //RichText with custom text span
          XsCusTextSpan(
            textSpans: [
              ITxtSpan(
                  text: 'hello--> ',
                  tapLink: 'https://www.baidu.com',
                  onTap: (val) {
                    OpenLink.launchURL(toUrl: val);
                  }),
              ITxtSpan(
                  icon: 'assets/images/unlike.png',
                  iconSel: 'assets/images/like.png',
                  iconSize: 28,
                  onTap: (val) {
                    print('=========> icon tap: $val');
                  }),
              ITxtSpan(text: ' helllllll '),
              ITxtSpan(
                  iconData: Icons.favorite,
                  iconDataSel: Icons.favorite_border,
                  iconSize: 28,
                  onTap: (val) {
                    print('=========> icon data tap: $val');
                  }),
            ],
            defHsty: const TextStyle(fontSize: 20, color: Colors.purple),
            defNSty: const TextStyle(fontSize: 20, color: Colors.red),
          ),
        ],
      ).paddingOnly(left: 16),
    );
  }
}
