package com.example.beyan_a

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.google.mediapipe.components.CameraXSource
import com.google.mediapipe.framework.AndroidAssetUtil
import com.google.mediapipe.solutions.hands.Hands
import com.google.mediapipe.solutions.hands.HandsOptions

class MediaPipePlugin: FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var hands: Hands
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.example.mediapipe/hands")
        context = flutterPluginBinding.applicationContext
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "initialize" -> initializeMediaPipe(result)
            "startCamera" -> startCameraStream(result)
            "stopCamera" -> stopCameraStream(result)
            else -> result.notImplemented()
        }
    }

    private fun initializeMediaPipe(result: MethodChannel.Result) {
        AndroidAssetUtil.initializeNativeAssetManager(context)
        hands = Hands(context, HandsOptions.builder().setStaticImageMode(false).setMaxNumHands(2).build())
        result.success("MediaPipe Hands initialized")
    }

    private fun startCameraStream(result: MethodChannel.Result) {
        result.success("Camera stream started")
    }

    private fun stopCameraStream(result: MethodChannel.Result) {
        result.success("Camera stream stopped")
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
