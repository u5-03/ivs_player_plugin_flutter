

import 'package:ivs_player_plugin/ivs_player_plugin.dart';

final class RequesterToFlutterCallbacks {
  RequesterToFlutterCallbacks({
    this.didChangeState,
    this.didChangeDuration,
  });
  void Function(PlayerState)? didChangeState;
  void Function(double)? didChangeDuration;
}
