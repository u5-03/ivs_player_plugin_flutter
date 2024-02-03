import 'package:ivs_player_plugin/ivs_player_plugin.dart';
import 'package:ivs_player_plugin/src/requester_to_flutter/requester_to_flutter_callbacks.dart';

final class RequesterToFlutterImp implements IvsPlayerRequesterToFlutter {
  RequesterToFlutterImp({required this.callbacks});

  final RequesterToFlutterCallbacks callbacks;

  @override
  void didChangeState(PlayerState state) {
    callbacks.didChangeState?.call(state);
  }

  @override
  void didChangeDuration(double duration) {
    callbacks.didChangeDuration?.call(duration);
  }
}
