import 'package:simple_mobile_auth/src/simple_mobile_auth_platform_interface.dart';
import 'package:simple_mobile_auth/src/utils/mobile_auth_content.dart';
import 'package:simple_mobile_auth/src/utils/mobile_auth_result.dart';

class SimpleMobileAuthService {
  Future<MobileResult> biometricAuthentication(MobileAuthContent content) {
    return SimpleMobileAuthPlatform.instance.biometricAuthentication(content);
  }
}
