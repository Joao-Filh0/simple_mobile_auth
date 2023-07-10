import 'package:simple_mobile_auth/src/utils/mobile_auth_result.dart';

class MobileHelpers {
  static MobileResult getResult(String result) {
    return MobileResult.values
        .firstWhere((element) => element.name == result.toLowerCase());
  }
}
