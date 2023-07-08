import 'package:simple_mobile_auth/utils/mobile_auth_content.dart';
import 'package:simple_mobile_auth/utils/mobile_auth_result.dart';

import 'simple_mobile_auth_platform_interface.dart';

class SimpleMobileAuth {
  Future<MobileResult> biometricAuthentication(MobileAuthContent content) {
    return SimpleMobileAuthPlatform.instance.biometricAuthentication(content);
  }
}
