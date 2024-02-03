import 'package:flutter/foundation.dart';
import 'package:ivs_player_plugin/ivs_player_plugin.dart';
import 'package:ivs_player_plugin/src/requester_to_flutter/requester_to_flutter_callbacks.dart';
import 'package:ivs_player_plugin/src/requester_to_flutter/requester_to_flutter_impl.dart';

final class IvsPlayerController extends ValueNotifier<IvsPlayerState> {
  IvsPlayerController({
    RequesterToFlutterCallbacks? callbacks,
  })  : _callbacks = callbacks,
        super(IvsPlayerState.empty()) {
    IvsPlayerRequesterToFlutter.setup(RequesterToFlutterImp(
        callbacks: RequesterToFlutterCallbacks(
      didChangeState: (state) {
        value = value.copyWith(playerState: state);
      },
      didChangeDuration: (duration) {
        value = value.copyWith(duration: duration);
      },
    )));
  }
  final _requester = IvsPlayerRequesterToNative();
  final RequesterToFlutterCallbacks? _callbacks;

  _setVideoUri(Uri uri) {
    value = value.copyWith(videoUri: uri);
  }

  load(Uri uri) {
    _setVideoUri(uri);
    _requester.load(uri.toString());
  }

  play() {
    _requester.play();
  }

  pause() {
    _requester.pause();
  }

  clean() {
    _requester.clean();
  }
}
