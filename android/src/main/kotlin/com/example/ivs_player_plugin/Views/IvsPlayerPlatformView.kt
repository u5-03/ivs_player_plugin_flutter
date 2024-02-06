package com.example.ivsPlayerPlugin.Views.ivsPlayerView

import CreateResponse
import IvsPlayerRequesterToFlutter
import IvsPlayerRequesterToNative
import PlayerState
import android.net.Uri
import android.view.View
import com.amazonaws.ivs.player.Cue
import com.amazonaws.ivs.player.Player
import com.amazonaws.ivs.player.PlayerException
import com.amazonaws.ivs.player.PlayerView
import com.amazonaws.ivs.player.Quality
import com.amazonaws.ivs.player.ResizeMode
import io.flutter.plugin.platform.PlatformView

class IvsPlayerPlatformView(
    private val id: String,
    private val requesterToFlutter: IvsPlayerRequesterToFlutter,
    private val playerView: PlayerView,
): PlatformView, IvsPlayerRequesterToNative {
    override fun getView(): View {
        return playerView;
    }

    override fun dispose() {
        playerView.player.release()
    }

    init {
        playerView.controlsEnabled = false;
        playerView.captionsEnabled = false;
       playerView.resizeMode = ResizeMode.FILL;
        playerView.player.addListener(object : Player.Listener() {
            override fun onError(p0: PlayerException) {
                requesterToFlutter.didChangeState(id, PlayerState.ERROR) {}
            }
            override fun onRebuffering() {}
            override fun onSeekCompleted(p0: Long) {}
            override fun onVideoSizeChanged(p0: Int, p1: Int) {}
            override fun onQualityChanged(p0: Quality) {}
            override fun onCue(p0: Cue) {}
            override fun onDurationChanged(duration: Long) {
                requesterToFlutter.didChangeDuration(id, duration.toDouble()) {}
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
                requesterToFlutter.didChangeState(id, playerState) {}
            }
        })
        print("IvsPlayerView init(kt)");
    }

    // MARK: RequesterToFlutter
    override fun create(): CreateResponse {
        TODO("Not yet implemented")
    }
    override fun load(id: String, urlString: String) {
        playerView.player.load(Uri.parse(urlString));
    }

    override fun play(id: String) {
        playerView.player.play();
    }

    override fun pause(id: String) {
        playerView.player.pause();
    }

    override fun clean(id: String) {
        playerView.player.release();
    }
}
