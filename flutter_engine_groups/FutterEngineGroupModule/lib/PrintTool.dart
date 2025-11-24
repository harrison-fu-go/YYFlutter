/*
 * PrintTool
 * Create by Harrison.Fu on 2024/1/9-16:49
 */

import 'package:flutter/foundation.dart';
import 'dart:core';
import 'package:stack_trace/stack_trace.dart';

void xDebugPrint(Object? object, {StackTrace? current}) {
    if (kDebugMode) {
      var chain = Chain.current(); // Chain.forTrace(StackTrace.current);
      // put core 和 flutter together（should include one record）
      chain = chain.foldFrames((frame) => frame.isCore || frame.package == "flutter");

      // get all frames
      final frames = chain.toTrace().frames;

      // find current function's element, if not include then would not print.
      final idx = frames.indexWhere((element) => element.member == "xDebugPrint");
      if (idx == -1 || idx+1 >= frames.length) {
        return;
      }
      // get the frame by index.
      final frame = frames[idx+1];
      final printStr = "${frame.uri.toString().split("/").last}(${frame.line}):$object";
      debugPrint(printStr);
    }
}
