package com.example.ivs_player_plugin.Views

import IvsPlayerRequesterToFlutter
import android.content.Context
import com.example.ivs_player_plugin.IvsPlayerFlutterPlugin
import com.example.ivs_player_plugin.IvsPlayerPlatoformRequester.IvsPlayerRequesterToNativeImpl
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class IvsPlayerViewFactory() : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params =
            args as? Map<String, Any> ?: error("`args` parameter must be `Map<String, Any>`!")
        val id = params["id"] as? String ?: error("`id` must be `String`!")
        return IvsPlayerFlutterPlugin.ivsPlayerViews[id] ?: error("id is invalid")
    }
}
