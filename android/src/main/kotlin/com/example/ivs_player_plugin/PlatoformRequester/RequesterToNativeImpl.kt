package com.example.ivs_player_plugin.IvsPlayerPlatoformRequester

import CreateResponse
import IvsPlayerRequesterToFlutter
import IvsPlayerRequesterToNative
import android.content.Context
import android.net.Uri
import com.amazonaws.ivs.player.PlayerView
import com.example.ivsPlayerPlugin.Views.ivsPlayerView.IvsPlayerPlatformView
import com.example.ivs_player_plugin.IvsPlayerFlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import java.util.UUID

class IvsPlayerRequesterToNativeImpl(private val context: Context, private val binaryMessenger: BinaryMessenger): IvsPlayerRequesterToNative {
    override fun create(): CreateResponse {
        val id = UUID.randomUUID().toString()
        val response = CreateResponse(id = id)
        val requester = IvsPlayerRequesterToFlutter(binaryMessenger);
        val playerView = PlayerView(context);
        val platformView = IvsPlayerPlatformView(id, requester, playerView);
        IvsPlayerFlutterPlugin.ivsPlayers[id] = playerView.player
        IvsPlayerFlutterPlugin.ivsPlayerViews[id] = platformView
        return response

    }
    override fun load(id: String, urlString: String) {
        IvsPlayerFlutterPlugin.ivsPlayers[id]?.load(Uri.parse(urlString));

    }

    override fun play(id: String) {
        IvsPlayerFlutterPlugin.ivsPlayers[id]?.play();
    }

    override fun pause(id: String) {
        IvsPlayerFlutterPlugin.ivsPlayers[id]?.pause();
    }

    override fun clean(id: String) {
        IvsPlayerFlutterPlugin.ivsPlayers[id]?.release();
    }
}