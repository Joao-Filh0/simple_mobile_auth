package com.example.simple_mobile_auth

import android.content.Context
import android.os.Build
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_STRONG
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterFragmentActivity

class BiometricHelper {
    companion object {
        fun isBiometricAvailable(context: Context): Boolean {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
                return false
            }
            val biometricManager = BiometricManager.from(context)
            when (biometricManager.canAuthenticate(BIOMETRIC_STRONG)) {

                BiometricManager.BIOMETRIC_SUCCESS -> return true
                BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE -> return false
                BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE -> return false
                BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> return false
            }
            return false
        }

        fun makePromptBiometric(
            title: String?,
            subtitle: String?,
            description: String?,
            negativeButtonText: String?
        ): BiometricPrompt.PromptInfo {
            val info = BiometricPrompt.PromptInfo.Builder()

            title?.let {
                info.setTitle(it)
            }
            subtitle?.let {
                info.setSubtitle(it)
            }
            description?.let {
                info.setDescription(it)

            }

            negativeButtonText?.let {
                info.setNegativeButtonText(it)
            }

            return info.build()


        }


        fun authentication(
            activity: FlutterFragmentActivity,
            promptInfo: BiometricPrompt.PromptInfo,
            onResult: (BiometricResult) -> Unit
        ) {

            val executor = ContextCompat.getMainExecutor(activity)
            val bio = BiometricPrompt(
                activity,
                executor,
                object : BiometricPrompt.AuthenticationCallback() {
                    override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                        super.onAuthenticationSucceeded(result)
                        onResult(BiometricResult.SUCCESS)
                    }

                    override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                        super.onAuthenticationError(errorCode, errString)
                        println("CODE $errorCode")
                        when {
                            BiometricPrompt.ERROR_LOCKOUT == errorCode ->{
                                onResult(BiometricResult.FAILED)
                            }

                            BiometricPrompt.ERROR_USER_CANCELED == errorCode ||
                                    BiometricPrompt.ERROR_NEGATIVE_BUTTON == errorCode -> {
                                onResult(BiometricResult.CANCEL)
                            }
                            else ->  onResult(BiometricResult.ERROR)

                        }
                    }
                })
            bio.authenticate(promptInfo)


        }
    }


}