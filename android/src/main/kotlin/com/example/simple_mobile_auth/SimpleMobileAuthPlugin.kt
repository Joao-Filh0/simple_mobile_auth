package com.example.simple_mobile_auth

import android.app.Activity
import androidx.annotation.NonNull
import androidx.biometric.BiometricPrompt
import io.flutter.embedding.android.FlutterFragmentActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


class SimpleMobileAuthPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "simple_mobile_auth")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "biometric") {
            val promptInfo = promptInfo(call)
            biometricAuthentication(result, promptInfo)

        } else {
            result.notImplemented()
        }
    }


    private fun biometricAuthentication(
        @NonNull result: Result,
        prompt: BiometricPrompt.PromptInfo
    ) {
        val isAvailable = BiometricHelper.isBiometricAvailable(activity)
        if (isAvailable) {


            BiometricHelper.authentication(
                activity as FlutterFragmentActivity,
                prompt
            ) { args ->
                result.success(args.name)
            }
        } else {
            result.success(BiometricResult.UNAVAILABLE.name)

        }
    }


    private fun promptInfo(@NonNull call: MethodCall): BiometricPrompt.PromptInfo {

        val title = call.argument<String>("androidTitle")
        val subTitle = call.argument<String>("androidSubTitle")
        val description = call.argument<String>("androidDescription")
        val negativeButtonText = call.argument<String>("negativeButtonText")

        return BiometricHelper.makePromptBiometric(
            title,
            subTitle,
            description,
            negativeButtonText,
        )

    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }
}
