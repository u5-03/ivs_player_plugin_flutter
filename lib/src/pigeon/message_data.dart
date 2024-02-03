// ignore_for_file: one_member_abstracts

// ignore: depend_on_referenced_packages
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon/generated/message_data.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/src/main/kotlin/com/example/ivs_player_plugin/Generated/IvsPlayerMessageData.g.kt',
    kotlinOptions: KotlinOptions(
      errorClassName: "IvsPlayerFlutterError",
    ),
    swiftOut: 'ios/Classes/Generated/MessageData.g.swift',
    swiftOptions: SwiftOptions(),
    copyrightHeader: 'lib/src/pigeon/generated/copyright.txt',
    dartPackageName: 'ivs_player_plugin',
  ),
)

enum PlayerState {
  ready,
  buffering,
  idle,
  playing,
  ended,
  error,
}


@HostApi() // Flutter -> Native
abstract class IvsPlayerRequesterToNative {
  void load(String urlString);
  void play();
  void pause();
  void clean();
}

@FlutterApi() // Native -> Flutter
abstract class IvsPlayerRequesterToFlutter {
  void didChangeState(PlayerState state);
  void didChangeDuration(double duration);
}
