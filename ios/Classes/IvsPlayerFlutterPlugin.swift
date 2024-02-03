import Flutter
import UIKit
import AmazonIVSPlayer

enum PlatformViewKind: String {
    case ivsPlayerView
}

public class IvsPlayerFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let player = IVSPlayer()
        let requester = IvsPlayerRequesterToFlutter(binaryMessenger: registrar.messenger())
        IvsPlayerRequesterToNativeSetup.setUp(binaryMessenger: registrar.messenger(), api: RequesterToNativeImpl(player: player))
        registrar.register(
            IvsPlayerViewFactory(messenger: registrar.messenger(), player: player, requester: requester),
            withId: PlatformViewKind.ivsPlayerView.rawValue
        )
    }
}
