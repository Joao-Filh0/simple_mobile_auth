import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:simple_mobile_auth/utils/mobile_auth_content.dart';
import 'package:simple_mobile_auth/utils/mobile_auth_content_model.dart';
import 'package:simple_mobile_auth/utils/mobile_auth_result.dart';
import 'package:simple_mobile_auth/utils/mobile_helpers.dart';

import 'simple_mobile_auth_platform_interface.dart';

class MethodChannelSimpleMobileAuth extends SimpleMobileAuthPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('simple_mobile_auth');

  @override
  Future<MobileResult> biometricAuthentication(
      MobileAuthContent content) async {
    final args = MobileAuthContentModel.fromObject(content);
    final result =
        await methodChannel.invokeMethod<String>('biometric', args.toMap());
    final mobileResult = MobileHelpers.getResult(result!);
    return mobileResult;
  }
}
