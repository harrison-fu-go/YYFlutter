/* File: open_link.dart
 * Created by GYGES.Harrison on 2025/4/18 at 11:17
 * Copyright © 2025 GYGES Limited. All rights reserved.
 */

import 'package:url_launcher/url_launcher.dart';

class OpenLink {
  static void launchURL({String? toUrl}) async {
    final url = Uri.parse(toUrl ?? 'https://www.example.com'); // 需要打开的链接
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('无法打开链接 $url');
    }
  }
}
