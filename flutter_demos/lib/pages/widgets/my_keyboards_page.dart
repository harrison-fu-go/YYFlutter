/* File: my_stateless_demo_page.dart
 * Created by GYGES.Harrison on 2025/9/4 at 17:49
 * Copyright © 2024 GYGES Limited.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyKeyboardsPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  MyKeyboardsPage({super.key}) {
    controller.text = 'Test keyboard';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keyboards'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 28),
          TextField(
            controller: controller,
            inputFormatters: [EmojiRemovingFormatter()],
            decoration: InputDecoration(
              // labelText: '输入文本',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0), // 圆角
                borderSide: const BorderSide(color: Colors.red, width: 1.0), // 红色边框
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.red, width: 1.0), // 聚焦时的红色边框
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.red, width: 1.0), // 默认的红色边框
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // 内部内容的 padding
            ),
            style: const TextStyle(fontSize: 18.0), // 设置字体大小
          )
        ],
      ).paddingSymmetric(horizontal: 16),
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
