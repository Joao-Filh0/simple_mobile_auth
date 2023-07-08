enum MobileResult {
  ///There is no error, and the user can successfully authenticate
  success,

  ///The current operation has been running too long and has timed out.
  ///This is intended to prevent programs from waiting for the biometric sensor indefinitely.
  /// The timeout is platform and sensor-specific, but is generally on the order of ~30 seconds.
  /// The operation can't be completed because there is not enough device storage remaining
  /// The operation was canceled because the biometric sensor is unavailable. This may happen
  /// when the user is switched, the device is locked, or another pending operation prevents it.
  /// The operation failed due to a vendor-specific error.This error code may be used by hardware vendors
  /// to extend this list to cover errors that don't fall under one of the other predefined categories. Vendors
  /// are responsible for providing the strings for these errors.These messages are typically reserved for
  /// internal operations such as enrollment but may be used to express any error that is not otherwise covered.
  /// In this case, applications are expected to show the error message, but they are advised not to rely on the
  /// message ID, since this may vary by vendor and device.
  /// The user canceled the operation. Upon receiving this, applications should use alternate authentication,
  /// such as a password. The application should also provide the user a way of returning to biometric authentication, such as a button.
  ///A security vulnerability has been discovered with one or more hardware sensors. The affected sensor(s) are unavailable until a security
  ///update has addressed the issue.
  ///An error code that may be returned during authentication.
  error,

  ///The operation was canceled because the API is locked out due to
  /// too many attempts. This occurs after 5 failed attempts, and lasts for 30 seconds.
  failed,

  ///The user canceled the operation.Upon receiving this, applications should use alternate
  ///authentication, such as a password. The application should also provide the user a way
  ///of returning to biometric authentication, such as a button.
  ///The user pressed the negative button.
  cancel,

  ///The hardware is unavailable. Try again later.
  unavailable,
}
