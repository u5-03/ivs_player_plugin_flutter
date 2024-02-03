import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ivs_player_plugin/ivs_player_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _ivsPlayerFlutterPlugin = IvsPlayerFlutter();
  final ivsPlayerController = IvsPlayerController();
  // final requesterToFlutter = RequesterToFlutter();

  @override
  void initState() {
    super.initState();
    initPlatformState();

    ivsPlayerController.addListener(() {
      print('Player State: ${ivsPlayerController.value.playerState}');
      if(ivsPlayerController.value.playerState == PlayerState.ready) {
        ivsPlayerController.play();
      }
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {

      // platformVersion = await _ivsPlayerFlutterPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Expanded(
                child: Builder(
                  builder: (context) {
                    return IvsPlayerWidget(ivsPlayerController: ivsPlayerController);
                  }
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your onPressed code here!
                    ivsPlayerController.load(Uri.parse('https://fcc3ddae59ed.us-west-2.playback.live-video.net/api/video/v1/us-west-2.893648527354.channel.YtnrVcQbttF0.m3u8'));
                  },
                  child: const Text('Play'),
                ),
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your onPressed code here!
                    ivsPlayerController.pause();
                  },
                  child: const Text('Pause'),
                ),
              )
              ],)
            ]),
          ),
        ),
      ),
    );
  }
}
