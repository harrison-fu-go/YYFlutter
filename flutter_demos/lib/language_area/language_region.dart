/* File: language_region.dart
 * Created by XianShun on 2024/9/20 at 11:47
 * Copyright © 2024 XianShun Limited.
 */
import 'package:flutter/material.dart';

class LanguageAndRegion {

  static String languageRegionCode() {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    final languageCode = locale.languageCode;
    final countryCode = locale.countryCode;
    final formattedLocale = '${languageCode}_$countryCode'; // 例如 en_US
    print('Current locale is: $formattedLocale');
    return formattedLocale;
  }

}