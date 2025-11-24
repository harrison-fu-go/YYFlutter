import 'package:get/get.dart';

import '../language_area/language_region.dart';

class CounterController extends GetxController {
  // 定义一个可观察的计数变量
  var count = 0.obs;

  // 增加计数的方法
  void increment() {
    count++;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('=== language code: ${ LanguageAndRegion.languageRegionCode() }');
  }
}