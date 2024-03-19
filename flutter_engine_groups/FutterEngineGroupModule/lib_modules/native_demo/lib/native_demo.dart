
import 'native_demo_platform_interface.dart';

class NativeDemo {
  Future<String?> getPlatformVersion() {
    return NativeDemoPlatform.instance.getPlatformVersion();
  }
}
