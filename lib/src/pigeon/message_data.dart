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

class CreateResponse {
  final String id;
  CreateResponse({required this.id});
}


@HostApi() // Flutter -> Native
abstract class IvsPlayerRequesterToNative {
  CreateResponse create();
  void load(String id, String urlString);
  void play(String id);
  void pause(String id);
  void clean(String id);
}

@FlutterApi() // Native -> Flutter
abstract class IvsPlayerRequesterToFlutter {
  void didChangeState(String id, PlayerState state);
  void didChangeDuration(String id, double duration);
}
