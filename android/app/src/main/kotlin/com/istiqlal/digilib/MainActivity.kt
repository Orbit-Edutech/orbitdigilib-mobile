package com.istiqlal.digilib

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.view.WindowManager.LayoutParams

class MainActivity: FlutterActivity() {
    private lateinit var methodChannel: MethodChannel
    private val channel = "com.istiqlal.digilib"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
        methodChannel.setMethodCallHandler {
            call, result ->
            when(call.method) { 
                "secure" -> {
                    val isSecure = call.argument<Boolean?>("isSecure")
                    if(isSecure ?: false){
                        window.addFlags(LayoutParams.FLAG_SECURE)
                    } else {
                        window.clearFlags(LayoutParams.FLAG_SECURE)
                    }
                    // result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
