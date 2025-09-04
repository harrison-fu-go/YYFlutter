import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'audio_cases_method_channel.dart';

abstract class AudioCasesPlatform extends PlatformInterface {
  /// Constructs a AudioCasesPlatform.
  AudioCasesPlatform() : super(token: _token);

  static final Object _token = Object();

  static AudioCasesPlatform _instance = MethodChannelAudioCases();

  /// The default instance of [AudioCasesPlatform] to use.
  ///
  /// Defaults to [MethodChannelAudioCases].
  static AudioCasesPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AudioCasesPlatform] when
  /// they register themselves.
  static set instance(AudioCasesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
