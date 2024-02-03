package com.example.ivs_player_plugin

import IvsPlayerRequesterToFlutter
import androidx.annotation.NonNull
import com.example.ivs_player_plugin.IvsPlayerPlatoformRequester.IvsPlayerRequesterToNativeImpl
import com.example.ivs_player_plugin.Views.IvsPlayerViewFactory

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

// After modified, must modify ios/dart definition too.
enum class PlatformViewKind(val rawValue: String) {
  IVS_PLAYER("ivsPlayerView")
}


/** IvsPlayerFlutterPlugin */
class IvsPlayerFlutterPlugin: FlutterPlugin {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val requesterToNative = IvsPlayerRequesterToNativeImpl();
    val requesterToFlutter = IvsPlayerRequesterToFlutter(flutterPluginBinding.binaryMessenger)
    IvsPlayerRequesterToNative.setUp(flutterPluginBinding.binaryMessenger, requesterToNative);
    flutterPluginBinding.platformViewRegistry
      .registerViewFactory(PlatformViewKind.IVS_PLAYER.rawValue, IvsPlayerViewFactory(requesterToFlutter, requesterToNative));
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    IvsPlayerRequesterToNative.setUp(binding.binaryMessenger, null)
  }
}
