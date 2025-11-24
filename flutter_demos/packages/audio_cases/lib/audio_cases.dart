
import 'audio_cases_platform_interface.dart';

class AudioCases {
  Future<String?> getPlatformVersion() {
    return AudioCasesPlatform.instance.getPlatformVersion();
  }
}
