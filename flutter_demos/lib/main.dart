import 'package:flutter/material.dart';
import 'package:flutter_demos/TexsSpans/custom_text_span.dart';
import 'package:flutter_demos/crypt/rsa.dart';
import 'package:flutter_demos/crypt/sha_256.dart';
import 'package:flutter_demos/date_time/YYDateTime.dart';
import 'package:flutter_demos/dio/dio_request.dart';
import 'package:flutter_demos/dio/download/download_service.dart';
import 'package:flutter_demos/language_area/language_region.dart';
import 'package:flutter_demos/system_info/app_info.dart';
import 'package:flutter_demos/system_info/device_info.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'getX/get_x_controller.dart';
import 'getX/get_x_second_page.dart';
import 'languages/languages.dart';
import 'package:test/test.dart';
void main() {
  /**
   * 测试rsa
   */
  String rsaEncryptVal = rsaEncrypt("NIhao ..... dhdhdhdh ");
  print("==== rsa encrypt val: $rsaEncryptVal");

  String rsaDecryptVal = rsaDecrypt(rsaEncryptVal);
  print("==== rsa Decrypt val: $rsaDecryptVal");

  //YYDateTime
  int now = DateTime.now().millisecondsSinceEpoch;
  int begin = YYDateTime.getDayStartTime(now);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(begin);
  print(
      "==== now: $now ==== begin: $begin === day: ${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}");
  Calculator.test();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      supportedLocales: const [
        Locale('en', ''), // 英文
        Locale('zh', ''), // 中文
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate, // 自定义的语言代理
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => MyHomePage(
                  title: 'message'.localized,
                )),
        GetPage(name: '/second', page: () => SecondPage()),
      ],
    );
  }
}

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

  @override
  void initState() {
    super.initState();
    DioRequest.setUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              // 使用 Obx 监听状态变化并更新 UI
              child: Obx(() => Text(
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
            const XsCusTextSpan(textInfos: [
              ('dsfsfsfsfs', TextStyle(fontSize: 20), link: null),
              ('dsfsfsfsfsdddd', null, link: null),
            ], defaultHighlightStyle: TextStyle(fontSize: 20),),
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
