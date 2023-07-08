import 'mobile_auth_content.dart';

class MobileAuthContentModel extends MobileAuthContent {
  MobileAuthContentModel(
      {required super.iosSubTitle,
      super.androidSubTitle,
      super.androidDescription,
      required super.androidTitle,
      required super.negativeButtonText});

  factory MobileAuthContentModel.fromObject(MobileAuthContent object) =>
      MobileAuthContentModel(
          iosSubTitle: object.iosSubTitle,
          androidTitle: object.androidTitle,
          negativeButtonText: object.negativeButtonText,
          androidSubTitle: object.androidSubTitle,
          androidDescription: object.androidDescription);

  Map<String, dynamic> toMap() => {
        "iosSubTitle": iosSubTitle,
        "androidTitle": androidTitle,
        "androidSubTitle": androidSubTitle,
        "androidDescription": androidDescription,
        "negativeButtonText": negativeButtonText
      };
}
