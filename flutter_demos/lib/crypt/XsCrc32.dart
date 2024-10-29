/* File: XsCrc32.dart
 * Created by GYGES on 2024/10/12 at 10:20
 * Copyright © 2024 GYGES Limited.
 */

import 'dart:io';

class CRC32 {
  static final List<int> _crc32Table = _createCRC32Table();

  // 生成 CRC32 查找表
  static List<int> _createCRC32Table() {
    List<int> table = List<int>.filled(256, 0);
    for (int i = 0; i < 256; i++) {
      int crc = i;
      for (int j = 0; j < 8; j++) {
        if ((crc & 1) != 0) {
          crc = (crc >> 1) ^ 0xEDB88320; // 多项式
        } else {
          crc >>= 1;
        }
      }
      table[i] = crc;
    }
    return table;
  }

  // 计算 CRC32 校验和
  static int computeCRC32(List<int> data) {
    int crc = 0xFFFFFFFF;
    for (int byte in data) {
      int index = (crc ^ byte) & 0xFF;
      crc = (crc >> 8) ^ _crc32Table[index];
    }
    return crc ^ 0xFFFFFFFF;
  }

  static Future<int> calculateFileCRC32({required String filePath}) async {
    // 读取文件内容
    File file = File(filePath);
    List<int> fileBytes = await file.readAsBytes();

    // 计算 CRC32 校验和
    return CRC32.computeCRC32(fileBytes);
  }
}