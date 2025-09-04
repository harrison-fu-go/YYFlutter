import 'package:flutter_test/flutter_test.dart';
import 'package:audio_cases/audio_cases.dart';
import 'package:audio_cases/audio_cases_platform_interface.dart';
import 'package:audio_cases/audio_cases_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAudioCasesPlatform
    with MockPlatformInterfaceMixin
    implements AudioCasesPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AudioCasesPlatform initialPlatform = AudioCasesPlatform.instance;

  test('$MethodChannelAudioCases is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAudioCases>());
  });

  test('getPlatformVersion', () async {
    AudioCases audioCasesPlugin = AudioCases();
    MockAudioCasesPlatform fakePlatform = MockAudioCasesPlatform();
    AudioCasesPlatform.instance = fakePlatform;

    expect(await audioCasesPlugin.getPlatformVersion(), '42');
  });
}
