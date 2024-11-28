import 'package:flutter/material.dart';
import 'package:flutter_demos/TexsSpans/custom_text_span.dart';
import 'package:flutter_demos/crypt/aes.dart';
import 'package:flutter_demos/crypt/hash_utils.dart';
import 'package:flutter_demos/crypt/rsa.dart';
import 'package:flutter_demos/crypt/sha_256.dart';
import 'package:flutter_demos/date_time/YYDateTime.dart';
import 'package:flutter_demos/dio/dio_request.dart';
import 'package:flutter_demos/dio/download/download_service.dart';
import 'package:flutter_demos/pages/home_test.dart';
import 'package:flutter_demos/pages/home_test1.dart';
import 'package:flutter_demos/system_info/app_info.dart';
import 'package:flutter_demos/system_info/device_info.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'TexsSpans/cus_text_icon_span.dart';
import 'contacts/contact_picker.dart';
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

  String aesKey = 'fImgTfZl9pCzJbLZ'; //abcdefgh12345678
  String aesIv = 'YZAcjv1yOnlhjHbd';
  String aesData = 'qq123456';
  //String aesResult = encryptCBC(aesData, aesKey, aesIv, padding: 'PKCS7');
  String aesResult = aesEncryptCBC(aesKey, aesIv, aesData);
  // vyZHjemWytlJAq0X/KKa0w==
  String baseData = aesDecryptCBC(aesKey, aesIv, 'beYdftvAq5gtc0pmQQ7plA==');
  print('===== aes result: $aesResult ====== $baseData');

  String md5result = iMd5('123456');
  print('===== md5result: $md5result');
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    double safeBottomH = MediaQuery.of(context).padding.bottom;
    print('===== $safeBottomH');
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
            page: () => HomePage()),
        GetPage(name: '/second', page: () => SecondPage()),
      ],
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // 当前选中的索引
  final PageController _pageController = PageController(); // 控制PageView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("BottomNavigationBar 切换页面")),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          const MyHomePage(title: 'My test page',),
          const HomePage2(),
          // Center(child: Text("个人中心")),
          ContactPickerPage()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // BottomNavigationBar 背景色
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: Colors.white,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
              // 点击BottomNavigationBar时跳转到对应的PageView页面
              _pageController.jumpToPage(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "搜索"),
              // BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
              BottomNavigationBarItem(icon: Icon(Icons.contacts), label: "联系人"),
            ],
          ),
        ),
      ),
    );
  }
}
