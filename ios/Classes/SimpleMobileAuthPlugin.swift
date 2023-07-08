import Flutter
import UIKit
import LocalAuthentication

enum BiometricResult: String {
    case success = "success"
    case failed = "failed"
    case error = "error"
    case cancel = "cancel"
    case unavailable = "unavailable"
}

public class SimpleMobileAuthPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "simple_mobile_auth", binaryMessenger: registrar.messenger())
        let instance = SimpleMobileAuthPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "biometric" {
            if let args = call.arguments as? [String: Any],
               let title = args["iosSubTitle"] as? String {
                authenticate(result: result, title: title)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Title is missing", details: nil))
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func authenticate(result: @escaping FlutterResult, title: String) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: title) {
                success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        result(BiometricResult.success.rawValue)
                    } else {
                        if let error = authenticationError as NSError? {
                            if error.code == LAError.userCancel.rawValue {
                                result(BiometricResult.cancel.rawValue)
                            }  else if error.code == LAError.biometryLockout.rawValue{
                                result(BiometricResult.failed.rawValue)
                            }
                            else {
                                result(BiometricResult.failed.rawValue)
                            }
                        } else {
                            result(BiometricResult.error.rawValue)
                        }
                    }
                }
            }
        } else {
            result(BiometricResult.error.rawValue)
        }
    }
}
