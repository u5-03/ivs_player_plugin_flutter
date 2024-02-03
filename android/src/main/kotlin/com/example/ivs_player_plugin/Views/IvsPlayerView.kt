package com.example.ivsPlayerPlugin.Views.ivsPlayerView

import IvsPlayerRequesterToFlutter
import IvsPlayerRequesterToNative
import PlayerState
import android.content.Context
import android.net.Uri
import android.view.View
import com.amazonaws.ivs.player.Cue
import com.amazonaws.ivs.player.MediaPlayer
import com.amazonaws.ivs.player.Player
import com.amazonaws.ivs.player.PlayerControlView
import com.amazonaws.ivs.player.PlayerException
import com.amazonaws.ivs.player.PlayerView
import com.amazonaws.ivs.player.Quality
import com.amazonaws.ivs.player.ResizeMode
import com.example.ivs_player_plugin.IvsPlayerPlatoformRequester.IvsPlayerRequesterToNativeImpl
import io.flutter.plugin.platform.PlatformView

internal class IvsPlayerWrapperView(context: Context, private val requesterToFlutter: IvsPlayerRequesterToFlutter, private val requesterToNative: IvsPlayerRequesterToNativeImpl, creationParams: Map<String?, Any?>?): PlatformView, IvsPlayerRequesterToNative {
    private val playerView: PlayerView;
    override fun getView(): View {
        return playerView;
    }

    override fun dispose() {
        playerView.player.release()
    }

    init {
        playerView = PlayerView(context);
        playerView.controlsEnabled = false;
        playerView.captionsEnabled = false;
//        playerView.resizeMode = ResizeMode.FILL;
        requesterToNative.setPlayer(playerView.player);
        playerView.player.addListener(object : Player.Listener() {
            override fun onError(p0: PlayerException) {
                requesterToFlutter.didChangeState(PlayerState.ERROR) {}
            }
            override fun onRebuffering() {}
            override fun onSeekCompleted(p0: Long) {}
            override fun onVideoSizeChanged(p0: Int, p1: Int) {}
            override fun onQualityChanged(p0: Quality) {}
            override fun onCue(p0: Cue) {}
            override fun onDurationChanged(duration: Long) {
                requesterToFlutter.didChangeDuration(duration.toDouble()) {}
            }
            override fun onStateChanged(state: Player.State) {
                val playerState: PlayerState = when (state) {
                    Player.State.READY -> PlayerState.READY
                    Player.State.BUFFERING -> PlayerState.BUFFERING
                    Player.State.PLAYING -> PlayerState.PLAYING
                    Player.State.IDLE -> PlayerState.IDLE
                    Player.State.ENDED -> PlayerState.ENDED
                    else -> PlayerState.IDLE
                }
                requesterToFlutter.didChangeState(playerState) {}
            }
        })
    }

    // MARK: RequesterToFlutter
    override fun load(urlString: String) {
        playerView.player.load(Uri.parse(urlString));
    }

    override fun play() {
        playerView.player.play();
    }

    override fun pause() {
        playerView.player.pause();
    }

    override fun clean() {
        playerView.player.release();
    }
}
