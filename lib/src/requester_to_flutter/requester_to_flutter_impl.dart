import 'package:ivs_player_plugin/ivs_player_plugin.dart';
import 'package:ivs_player_plugin/src/requester_to_flutter/requester_to_flutter_callbacks.dart';

final class RequesterToFlutterImp implements IvsPlayerRequesterToFlutter {
  RequesterToFlutterImp({required this.id, required this.callbacks});

  final String id;
  final RequesterToFlutterCallbacks callbacks;

  @override
  void didChangeState(String id, PlayerState state) {
    // if (id != this.id) return;
    callbacks.didChangeState?.call(state);
  }

  @override
  void didChangeDuration(String id, double duration) {
    // if (id != this.id) return;
    callbacks.didChangeDuration?.call(duration);
  }
}
