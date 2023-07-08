import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:simple_mobile_auth/utils/mobile_auth_content.dart';
import 'package:simple_mobile_auth/utils/mobile_auth_result.dart';

import 'simple_mobile_auth_method_channel.dart';

abstract class SimpleMobileAuthPlatform extends PlatformInterface {
  /// Constructs a SimpleMobileAuthPlatform.
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
