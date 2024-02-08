package com.example.ivs_player_plugin

import android.content.Context
import android.view.View
import com.amazonaws.ivs.player.Player
import com.example.ivs_player_plugin.IvsPlayerPlatoformRequester.IvsPlayerRequesterToNativeImpl
import com.example.ivs_player_plugin.Views.IvsPlayerViewFactory

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.platform.PlatformView

// After modified, must modify ios/dart definition too.
enum class IvsPlatformViewKind(val rawValue: String) {
  IVS_PLAYER("ivsPlayerView")
}


/** IvsPlayerFlutterPlugin */
class IvsPlayerFlutterPlugin: FlutterPlugin {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  companion object {
    var ivsPlayers: MutableMap<String, Player> = mutableMapOf();
    var ivsPlayerViews: MutableMap<String, PlatformView> = mutableMapOf();
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {

    val requesterToNative = IvsPlayerRequesterToNativeImpl(flutterPluginBinding);
    IvsPlayerRequesterToNative.setUp(flutterPluginBinding.binaryMessenger, requesterToNative);
    flutterPluginBinding.platformViewRegistry
      .registerViewFactory(IvsPlatformViewKind.IVS_PLAYER.rawValue, IvsPlayerViewFactory());
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    IvsPlayerRequesterToNative.setUp(binding.binaryMessenger, null)
    ivsPlayers.clear();
    ivsPlayerViews.clear();
  }
}
