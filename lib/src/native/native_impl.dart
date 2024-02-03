import 'package:ivs_player_plugin/ivs_player_plugin.dart';

final class NativeImpl implements IvsPlayerRequesterToNative {
  final IvsPlayerRequesterToNative requester = IvsPlayerRequesterToNative();

  @override
  Future<void> clean() async {
    requester.clean();
  }

  @override
  Future<void> load(String urlString) async {
    requester.load(urlString);
  }

  @override
  Future<void> pause() async {
    requester.play();
  }

  @override
  Future<void> play() async {
    requester.pause();
  }
}
