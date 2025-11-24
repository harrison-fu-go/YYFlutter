import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_demo_method_channel.dart';

abstract class NativeDemoPlatform extends PlatformInterface {
  /// Constructs a NativeDemoPlatform.
  NativeDemoPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeDemoPlatform _instance = MethodChannelNativeDemo();

  /// The default instance of [NativeDemoPlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeDemo].
  static NativeDemoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeDemoPlatform] when
  /// they register themselves.
  static set instance(NativeDemoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
