import 'package:flutter_test/flutter_test.dart';
import 'package:simple_mobile_auth/simple_mobile_auth.dart';
import 'package:simple_mobile_auth/simple_mobile_auth_platform_interface.dart';
import 'package:simple_mobile_auth/simple_mobile_auth_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSimpleMobileAuthPlatform
    with MockPlatformInterfaceMixin
    implements SimpleMobileAuthPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SimpleMobileAuthPlatform initialPlatform = SimpleMobileAuthPlatform.instance;

  test('$MethodChannelSimpleMobileAuth is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSimpleMobileAuth>());
  });

  test('getPlatformVersion', () async {
    SimpleMobileAuth simpleMobileAuthPlugin = SimpleMobileAuth();
    MockSimpleMobileAuthPlatform fakePlatform = MockSimpleMobileAuthPlatform();
    SimpleMobileAuthPlatform.instance = fakePlatform;

    expect(await simpleMobileAuthPlugin.getPlatformVersion(), '42');
  });
}
