package com.marsa.marsa_hr
import android.location.Location
import android.location.LocationManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "com.marsa.attendance/location"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "isMockLocation") {
                val lm = getSystemService(LOCATION_SERVICE) as LocationManager
                val providers = lm.getProviders(true)

                var isMock = false
                for (provider in providers) {
                    val location: Location? = lm.getLastKnownLocation(provider)
                    if (location != null && location.isFromMockProvider) {
                        isMock = true
                        break
                    }
                }
                result.success(isMock)
            }
        }
    }
}
