package com.example.ivs_player_plugin.IvsPlayerPlatoformRequester

import CreateResponse
import IvsPlayerRequesterToFlutter
import IvsPlayerRequesterToNative
import android.content.Context
import android.graphics.Color
import android.net.Uri
import android.view.View
import com.amazonaws.ivs.player.PlayerView
import com.example.ivsPlayerPlugin.Views.ivsPlayerView.IvsPlayerPlatformView
import com.example.ivs_player_plugin.IvsPlayerFlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin
import java.util.UUID

class IvsPlayerRequesterToNativeImpl(private val flutterPluginBinding: FlutterPlugin.FlutterPluginBinding): IvsPlayerRequesterToNative {
    override fun create(): CreateResponse {
        val id = UUID.randomUUID().toString()
        val response = CreateResponse(id = id)
        val requester = IvsPlayerRequesterToFlutter(flutterPluginBinding.binaryMessenger);
        val context: Context = flutterPluginBinding.applicationContext;
        val playerView = PlayerView(context);
        val view = View(context);
        view.setBackgroundColor(Color.BLUE);
        val platformView = IvsPlayerPlatformView(id, requester, playerView, view);
        IvsPlayerFlutterPlugin.ivsPlayers[id] = playerView.player
        IvsPlayerFlutterPlugin.ivsPlayerViews[id] = platformView
        return response
    }

    override fun removeExcept(id: String) {
        IvsPlayerFlutterPlugin.ivsPlayers = IvsPlayerFlutterPlugin.ivsPlayers.filter { it.key == id }.toMutableMap()
        IvsPlayerFlutterPlugin.ivsPlayerViews = IvsPlayerFlutterPlugin.ivsPlayerViews.filter { it.key == id }.toMutableMap()
    }

    override fun resetAll() {
        IvsPlayerFlutterPlugin.ivsPlayers.clear();
        IvsPlayerFlutterPlugin.ivsPlayerViews.clear();
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
        IvsPlayerFlutterPlugin.ivsPlayers.remove(id);
        IvsPlayerFlutterPlugin.ivsPlayerViews.remove(id);
    }
}