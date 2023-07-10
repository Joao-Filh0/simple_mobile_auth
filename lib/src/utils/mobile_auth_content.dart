class MobileAuthContent {
  final String iosSubTitle;
  final String androidTitle;
  final String? androidSubTitle;
  final String? androidDescription;
  final String negativeButtonText;

  MobileAuthContent(
      {required this.iosSubTitle,
      required this.androidTitle,
      this.androidSubTitle,
      this.androidDescription,
      required this.negativeButtonText});
}
