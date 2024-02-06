import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ivs_player_plugin/ivs_player_plugin.dart';
import 'package:ivs_player_plugin/src/constants/platform_view_kind.dart';

final class IvsPlayerWidget extends StatelessWidget {
  const IvsPlayerWidget({required this.ivsPlayerController, super.key});

  final IvsPlayerController ivsPlayerController;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return _iOSWidget();
        } else if (Platform.isAndroid) {
          return _androidWidget();
        } else {
          return const Text('Unrecognized Platform.');
        }
      },
    );
  }

  Widget _iOSWidget() {
    return UiKitView(
      viewType: PlatformViewKind.ivsPlayerView.rawValue,
      creationParams: {
        'id': ivsPlayerController.id,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  Widget _androidWidget() {
    return PlatformViewLink(
      viewType: PlatformViewKind.ivsPlayerView.rawValue,
      surfaceFactory: (
        BuildContext context,
        PlatformViewController controller,
      ) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (PlatformViewCreationParams params) {
        final controller = PlatformViewsService.initExpensiveAndroidView(
          id: params.id,
          viewType: PlatformViewKind.ivsPlayerView.rawValue,
          layoutDirection: TextDirection.ltr,
          creationParams: {
            'id': ivsPlayerController.id,
          },
          creationParamsCodec: const StandardMessageCodec(),
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
        return controller;
      },
    );
  }
}
