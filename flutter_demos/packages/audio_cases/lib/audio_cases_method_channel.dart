import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'audio_cases_platform_interface.dart';

/// An implementation of [AudioCasesPlatform] that uses method channels.
class MethodChannelAudioCases extends AudioCasesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('audio_cases');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
