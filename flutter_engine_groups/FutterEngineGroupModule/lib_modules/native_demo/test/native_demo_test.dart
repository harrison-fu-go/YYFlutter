import 'package:flutter_test/flutter_test.dart';
import 'package:native_demo/native_demo.dart';
import 'package:native_demo/native_demo_platform_interface.dart';
import 'package:native_demo/native_demo_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeDemoPlatform
    with MockPlatformInterfaceMixin
    implements NativeDemoPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NativeDemoPlatform initialPlatform = NativeDemoPlatform.instance;

  test('$MethodChannelNativeDemo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeDemo>());
  });

  test('getPlatformVersion', () async {
    NativeDemo nativeDemoPlugin = NativeDemo();
    MockNativeDemoPlatform fakePlatform = MockNativeDemoPlatform();
    NativeDemoPlatform.instance = fakePlatform;

    expect(await nativeDemoPlugin.getPlatformVersion(), '42');
  });
}
