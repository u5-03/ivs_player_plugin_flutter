import 'package:flutter_test/flutter_test.dart';
import 'package:ivs_player_plugin/ivs_player_plugin.dart';
import 'package:ivs_player_plugin/ivs_player_plugin_platform_interface.dart';
import 'package:ivs_player_plugin/ivs_player_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIvsPlayerFlutterPlatform
    with MockPlatformInterfaceMixin
    implements IvsPlayerFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final IvsPlayerFlutterPlatform initialPlatform = IvsPlayerFlutterPlatform.instance;

  test('$MethodChannelIvsPlayerFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIvsPlayerFlutter>());
  });

  test('getPlatformVersion', () async {
    IvsPlayerFlutter ivsPlayerFlutterPlugin = IvsPlayerFlutter();
    MockIvsPlayerFlutterPlatform fakePlatform = MockIvsPlayerFlutterPlatform();
    IvsPlayerFlutterPlatform.instance = fakePlatform;

    expect(await ivsPlayerFlutterPlugin.getPlatformVersion(), '42');
  });
}
