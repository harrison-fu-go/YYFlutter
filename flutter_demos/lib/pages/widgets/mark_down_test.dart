/* File: mark_down_test.dart
 * Created by GYGES.Harrison on 2025/9/4 at 17:32
 * Copyright © 2024 GYGES Limited.
 */

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

const String markdownText = '''
## Proprietary Rights

Our Services and associated content (and any derivative works or enhancements of the same) including, but not limited to, all text, fonts, illustrations, files, images, software, scripts, graphics, photos, sounds, music, videos, information, content, materials, products, services, URLs, technology, documentation, and interactive features included with or available through our Services (collectively, the “Service Content”) and all intellectual property rights to the same are owned by us, our licensors, or both.
Additionally, all trademarks, service marks, trade names and trade dress that may appear in our Services are owned by us, our licensors, or identified third parties. Except for the limited use rights granted to you in these Terms of Use, you shall not acquire any right, title or interest in our Services or any Service Content. Any rights not expressly granted in these Terms of Use are expressly reserved.

## User-Generated Content

If, at our request, you send certain specific submissions (for example contest entries) or without a request from us you send creative ideas, suggestions, proposals, plans, or other materials, whether online, by email, by postal mail, or otherwise (collectively, comments), you agree that we may, at any time, without restriction, edit, copy, publish, distribute, translate and otherwise use in any medium any comments that you forward to us.

We are and shall be under no obligation:
1. to maintain any comments in confidence;
2. to pay compensation for any comments.
''';

class MarkDownTestPage extends StatelessWidget {
  const MarkDownTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hello develop'),
        ),
        body: SizedBox(
          height: Get.height - 200,
          child: const Markdown(data: markdownText),
        ).paddingSymmetric(horizontal: 16));
  }
}
