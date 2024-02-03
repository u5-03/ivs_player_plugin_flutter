package com.example.ivs_player_plugin.IvsPlayerPlatoformRequester

import IvsPlayerRequesterToNative
import android.net.Uri
import com.amazonaws.ivs.player.Player

class IvsPlayerRequesterToNativeImpl(): IvsPlayerRequesterToNative {
    var ivsPlayer: Player? = null;

    fun setPlayer(player: Player) {
        ivsPlayer = player;
    }

    override fun load(urlString: String) {
        ivsPlayer?.load(Uri.parse(urlString));
    }

    override fun play() {
        ivsPlayer?.play();
    }

    override fun pause() {
        ivsPlayer?.pause();
    }

    override fun clean() {
        ivsPlayer?.release();
    }
}