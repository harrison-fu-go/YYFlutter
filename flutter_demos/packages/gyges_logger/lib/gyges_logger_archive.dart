/* File: gyges_logger_archive.dart
 * Created by GYGES.Harrison on 2025/3/27 at 09:45
 * Copyright © 2025 GYGES Limited. All rights reserved.
 */

import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';

class ZipUtil {

  static Future<File> compressStringToZip({
    required String content,
    required String fileName,  //no .zip extension.
    bool saveInCache = true,  //is save in cache.
  }) async {
    // 1. change to utf8 encode.
    final contentBytes = utf8.encode(content);
    final archive = Archive();
    // 3. add file.
    archive.addFile(ArchiveFile(
      '$fileName.txt',  // file name.
      contentBytes.length,
      contentBytes,
    ));
    // 4. encode ZIP
    final zipBytes = ZipEncoder().encode(archive);
    if (zipBytes == null) {
      throw Exception('ZIP编码失败');
    }
    // 5. get the file path.
    final directory = saveInCache
        ? await getTemporaryDirectory()
        : await getApplicationDocumentsDirectory();
    // 6. create ZIP file
    final zipFile = File('${directory.path}/$fileName.zip');
    await zipFile.writeAsBytes(zipBytes);
    return zipFile;
  }

}