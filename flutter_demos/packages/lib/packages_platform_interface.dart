import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'packages_method_channel.dart';

abstract class PackagesPlatform extends PlatformInterface {
  /// Constructs a PackagesPlatform.
  PackagesPlatform() : super(token: _token);

  static final Object _token = Object();

  static PackagesPlatform _instance = MethodChannelPackages();

  /// The default instance of [PackagesPlatform] to use.
  ///
  /// Defaults to [MethodChannelPackages].
  static PackagesPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PackagesPlatform] when
  /// they register themselves.
  static set instance(PackagesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
