/* File: image_test.dart
 * Created by XianShun on 2024/9/25 at 10:52
 * Copyright © 2024 XianShun Limited.
 */

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

extension StringImg on String {

  Widget base64Img() {
    Uint8List bytes = base64Decode(this);
    return Image.memory(bytes);
  }

}