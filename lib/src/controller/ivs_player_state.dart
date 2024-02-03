import 'package:ivs_player_plugin/ivs_player_plugin.dart';

class IvsPlayerState {
  const IvsPlayerState({
    this.playerState = PlayerState.idle,
    this.videoUri,
    this.duration = 0,
    this.position = 0,
  });
  final PlayerState playerState;
  final Uri? videoUri;
  final double duration;
  final double position;

  factory IvsPlayerState.empty() => const IvsPlayerState();

  bool get isPlaying => playerState == PlayerState.playing;

  IvsPlayerState copyWith({
    PlayerState? playerState,
    Uri? videoUri,
    double? duration,
    double? position,
  }) {
    return IvsPlayerState(
      playerState: playerState ?? this.playerState,
      videoUri: videoUri ?? this.videoUri,
      duration: duration ?? this.duration,
      position: position ?? this.position,
    );
  }
}
