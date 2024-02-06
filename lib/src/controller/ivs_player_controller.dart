import 'package:flutter/foundation.dart';
import 'package:ivs_player_plugin/ivs_player_plugin.dart';
import 'package:ivs_player_plugin/src/requester_to_flutter/requester_to_flutter_callbacks.dart';
import 'package:ivs_player_plugin/src/requester_to_flutter/requester_to_flutter_impl.dart';

final class IvsPlayerController extends ValueNotifier<IvsPlayerState> {
  IvsPlayerController({
    required this.uri,
    RequesterToFlutterCallbacks? callbacks,
  })  : _callbacks = callbacks,
        super(IvsPlayerState.empty()) {}
  final _requester = IvsPlayerRequesterToNative();
  final RequesterToFlutterCallbacks? _callbacks;
  static const String kUninitializedTextureId = '';
  String _id = kUninitializedTextureId;
  String get id => _id;
  final Uri uri;

  Future<void> initialize() async {
    _id = (await _requester.create()).id;
    final requesterToFlutter = RequesterToFlutterImp(
        id: _id,
        callbacks: RequesterToFlutterCallbacks(
          didChangeState: (state) {
            _callbacks?.didChangeState?.call(state);
            value = value.copyWith(playerState: state);
          },
          didChangeDuration: (duration) {
            _callbacks?.didChangeDuration?.call(duration);
            value = value.copyWith(duration: duration);
          },
        ));
    IvsPlayerRequesterToFlutter.setup(requesterToFlutter);
    _load(uri);
    return Future.value(());
  }

  _setVideoUri(Uri uri) {
    value = value.copyWith(videoUri: uri);
  }

  _load(Uri uri) {
    _setVideoUri(uri);
    _requester.load(_id, uri.toString());
  }

  play() {
    _requester.play(_id);
  }

  pause() {
    _requester.pause(_id);
  }

  clean() {
    _requester.clean(_id);
  }
}
