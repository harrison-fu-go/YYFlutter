/* File: home_demo.dart
 * Created by GYGES.Harrison on 2025/3/28 at 17:28
 * Copyright © 2025 GYGES Limited. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demos/http_link/open_link.dart';
import 'package:flutter_demos/scroll_demo/gears_scroll.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../flavors.dart';

final String markdownText = '''
## Proprietary Rights

Our Services and associated content (and any derivative works or enhancements of the same) including, but not limited to, all text, fonts, illustrations, files, images, software, scripts, graphics, photos, sounds, music, videos, information, content, materials, products, services, URLs, technology, documentation, and interactive features included with or available through our Services (collectively, the “Service Content”) and all intellectual property rights to the same are owned by us, our licensors, or both.
Additionally, all trademarks, service marks, trade names and trade dress that may appear in our Services are owned by us, our licensors, or identified third parties. Except for the limited use rights granted to you in these Terms of Use, you shall not acquire any right, title or interest in our Services or any Service Content. Any rights not expressly granted in these Terms of Use are expressly reserved.

## User-Generated Content

If, at our request, you send certain specific submissions (for example contest entries) or without a request from us you send creative ideas, suggestions, proposals, plans, or other materials, whether online, by email, by postal mail, or otherwise (collectively, comments), you agree that we may, at any time, without restriction, edit, copy, publish, distribute, translate and otherwise use in any medium any comments that you forward to us.

We are and shall be under no obligation:
1. to maintain any comments in confidence;
2. to pay compensation for any comments.
''';

class HomeDemoPage extends StatefulWidget {
  const HomeDemoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeDemoPageState();
  }
}

class _HomeDemoPageState extends State<HomeDemoPage> {
  TextEditingController controller = TextEditingController();
  String oldInput = '';
  @override
  void initState() {
    super.initState();
    controller.text = 'Test';
    oldInput = 'Test';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(F.title),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'Hello ${F.title}',
            ),
          ),
          SizedBox(
            height: 30,
            //test 键盘
            child: TextField(
              controller: controller,
              inputFormatters: [EmojiRemovingFormatter()],
            ),
          ),
          //测试 open http link
          ElevatedButton(
              onPressed: () {
                OpenLink.launchURL();
              },
              child: const Text('open http link')),
          SizedBox(height: 200, child: Markdown(data: markdownText)),
          const SizedBox(height: 32),
          SlotSlider(),
        ],
      ),
    );
  }
}

class EmojiRemovingFormatter extends TextInputFormatter {
  static final emojiRegex = RegExp(
    r'\p{Emoji}',
    unicode: true,
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 只比较新旧文本差异部分
    if (newValue.text.length > oldValue.text.length) {
      final newChars = newValue.text.substring(oldValue.text.length);
      if (emojiRegex.hasMatch(newChars)) {
        return oldValue; // 拒绝包含emoji的输入
      }
    }
    return newValue;
  }
}
