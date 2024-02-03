package com.example.ivs_player_plugin.Views

import IvsPlayerRequesterToFlutter
import android.content.Context
import com.example.ivsPlayerPlugin.Views.ivsPlayerView.IvsPlayerWrapperView
import com.example.ivs_player_plugin.IvsPlayerPlatoformRequester.IvsPlayerRequesterToNativeImpl
import java.util.*
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class IvsPlayerViewFactory(private val requesterToFlutter: IvsPlayerRequesterToFlutter, private val requesterToNative: IvsPlayerRequesterToNativeImpl) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return IvsPlayerWrapperView(context, requesterToFlutter, requesterToNative, null);
    }
}
