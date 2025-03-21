
import 'packages_platform_interface.dart';

class Packages {
  Future<String?> getPlatformVersion() {
    return PackagesPlatform.instance.getPlatformVersion();
  }
}
