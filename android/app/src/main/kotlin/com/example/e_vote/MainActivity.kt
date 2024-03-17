package com.example.e_vote

import android.provider.Settings
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

private const val DEVELOPER_OPTIONS_CHECK_METHOD_CHANNEL = "eVote/developerOptionsCheckChannel"

class MainActivity : FlutterFragmentActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            DEVELOPER_OPTIONS_CHECK_METHOD_CHANNEL
        ).setMethodCallHandler { call, result ->
            run {
                when (call.method) {
                    "isDeveloperOptionsEnabled" -> {
                        try {
                            val isEnabled = isDeveloperOptionsEnabled()
                            result.success(isEnabled)
                        } catch (e: Exception) {
                            result.error("", "Error getting isDeveloperOptionsEnabled", e.message)
                        }
                    }

                    else -> result.notImplemented()
                }
            }
        }
    }

    private fun isDeveloperOptionsEnabled(): Boolean {
        return Settings.Secure.getInt(
            this.contentResolver,
            Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 0
        ) != 0
    }
}
