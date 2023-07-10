import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:simple_mobile_auth/src/simple_mobile_auth_method_channel.dart';
import 'package:simple_mobile_auth/src/utils/mobile_auth_content.dart';
import 'package:simple_mobile_auth/src/utils/mobile_auth_result.dart';

abstract class SimpleMobileAuthPlatform extends PlatformInterface {
  SimpleMobileAuthPlatform() : super(token: _token);

  static final Object _token = Object();

  static SimpleMobileAuthPlatform _instance = MethodChannelSimpleMobileAuth();

  static SimpleMobileAuthPlatform get instance => _instance;

  static set instance(SimpleMobileAuthPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<MobileResult> biometricAuthentication(MobileAuthContent content) {
    throw UnimplementedError(
        ' biometricAuthentication() has not been implemented.');
  }
}
