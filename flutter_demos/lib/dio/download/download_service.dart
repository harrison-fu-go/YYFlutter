/* File: download_service.dart
 * Created by GYGES on 2024/10/11 at 17:15
 * Copyright © 2024 GYGES Limited.
 */

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../../crypt/XsCrc32.dart';

class DownloadService {
  static DownloadService global = DownloadService();
  static DownloadService get to {
    return global;
  }

  final Dio downloadDio = Dio();
  CancelToken? cancelToken; // 用于控制取消下载
  RandomAccessFile? raf;
  double lastProgress = 0.0;
  bool isDownloading = false;
}

///断点续传下载ota文件
extension DownloadServiceResume on DownloadService {
  // 获取文件的临时保存路径
  Future<String> _getFilePath(String filename) async {
    Directory appDocDir = await getApplicationCacheDirectory();
    String appDocPath = appDocDir.path;
    appDocPath = '$appDocPath/xs_downloads';
    Directory newFolder = Directory(appDocPath);

    ///如果不存在，则创建文件夹
    if (!(await newFolder.exists())) {
      await newFolder.create(recursive: true);
      print('下载文件夹创建成功: $appDocPath');
    }
    return '$appDocPath/$filename';
  }

  // 获取文件大小
  Future<int> _getFileLength(String filePath) async {
    File file = File(filePath);
    if (await file.exists()) {
      return await file.length();
    }
    return 0;
  }

  /// 断点下载功能
  Future<void> downloadFile(
      {required String url,
      required String filename,
      required int checkSum,
      Function(double)? progressHandle, //value 0.0-1.0
      required Function(bool, String message) completionHandle}) async {
    //如果在下载，则返回
    if (isDownloading) {
      return;
    }
    isDownloading = true;
    //获取文件，路径文件大小
    String filePath = await _getFilePath(filename);
    int fileLength = await _getFileLength(filePath);
    //判断已存在下载的文件, 文件长度<=10 证明是不完整的。
    if (checkSum != null && fileLength > 10) {
      int fileCheck = await calculateCheckSum(filename: filename);
      if (checkSum == fileCheck) {
        //如果相等，则证明下载完成完整的包
        progressHandle?.call(1.0);
        completionHandle(true, '已存在下载完成的文件。');
        print("下载文件--> 已存在下载完成的文件");
        return;
      }
    }
    cancelToken = CancelToken();
    lastProgress = 0.0;
    try {
      // 添加 range 请求头，从 fileLength 位置开始继续下载
      Response response = await downloadDio.get(url,
          cancelToken: cancelToken,
          options: Options(
            responseType: ResponseType.stream,
            headers: {
              'Range': 'bytes=$fileLength-',
            },
          ), onReceiveProgress: (rcvLen, total) {
        int allLen = fileLength + total;
        int hadRcv = fileLength + rcvLen;
        double progress = hadRcv / allLen;
        //进度控制，相差0.01才打印或者上报
        double last = (lastProgress * 100).round() / 100;
        double curr = (progress * 100).round() / 100;
        if (lastProgress == 0.0 || curr - last >= 0.01 || (last != 1.0 && curr == 1.0)) {
          print("下载文件进度：--> 总：$allLen， 已经下载： $hadRcv， 进度： $curr");
          progressHandle?.call(curr);
        }
        if (hadRcv == allLen) {
          // 延迟 0.5 秒后执行
          Future.delayed(const Duration(milliseconds: 500)).then((_) async {
            int fileCheckSum = await calculateCheckSum(filename: filename);
            if (fileCheckSum == checkSum) {
              print("下载文件 --> checkSum 校验成功，下载完成！");
              completionHandle(true, 'Successfully!');
            } else {
              print("下载文件 --> checkSum 校验失败，下载失败！");
              await removeFile(filename);
              completionHandle(false, '下载失败，checkSum 校验通过!');
            }
          });
        }
        lastProgress = progress;
      });

      // 打开文件，并设置为 append 模式
      File file = File(filePath);
      raf = file.openSync(mode: FileMode.append);
      // 保存数据块
      await response.data!.stream.listen(
        (data) {
          // print("下载文件-----${rcvTotalLength + data.length}"); 这里不做进度
          // rcvTotalLength = rcvTotalLength + int.parse('${data.length}');
          raf?.writeFromSync(data);
        },
        onDone: () {
          print("下载文件--> onDone");
          closeRaf();
          isDownloading = false;
        },
        onError: (e) {
          print("下载文件--> $e");
          completionHandle(false, 'Download exception!');
          closeRaf();
          isDownloading = false;
        },
      );
    } catch (e) {
      print("下载文件--> 下载错误: $e");
      isDownloading = false;
    }
  }

  ///关闭文件流io
  closeRaf() {
    raf?.closeSync();
    raf = null;
  }

  ///暂停下载
  void pauseDownload({Function(bool)? completionCallback}) {
    if (cancelToken != null && !cancelToken!.isCancelled) {
      cancelToken!.cancel("Pause download");
      cancelToken = null;
      completionCallback?.call(true);
    }
  }

  ///移除下载文件
  Future<bool> removeFile(String filename) async {
    String filePath = await _getFilePath(filename);
    File file = File(filePath);
    // 检查文件是否存在
    if (file.existsSync()) {
      file.deleteSync(); // 同步删除文件
      print('====文件已删除');
    } else {
      print('=====文件不存在');
    }
    return true;
  }

  ///计算checkSum
  Future<int> calculateCheckSum({required String filename}) async {
    // 获取文件路径
    String filePath = await _getFilePath(filename);
    // 获取文件路径
    int crc32 = await CRC32.calculateFileCRC32(filePath: filePath);
    print('==== checkSum:int:$crc32---hex: ${crc32.toRadixString(16)}'); //.padLeft(8, '0').toUpperCase()
    return crc32;
  }
}

enum DownloadTaskType { apk, firmware }
