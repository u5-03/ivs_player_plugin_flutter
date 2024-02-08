import Flutter
import UIKit
import AmazonIVSPlayer

enum PlatformViewKind: String {
    case ivsPlayerView
}

public class IvsPlayerFlutterPlugin: NSObject, FlutterPlugin {
    static var ivsPlayers : [String: IVSPlayer] = [:]
    static var ivsPlayerViews: [String: IvsPlayerPlatformView] = [:]
    static var ivsPlayerDelegates: [String: IvsPlayerDelegate] = [:]

    public static func register(with registrar: FlutterPluginRegistrar) {
        IvsPlayerRequesterToNativeSetup.setUp(binaryMessenger: registrar.messenger(), api: RequesterToNativeImpl(registrar: registrar))
        registrar.register(
            IvsPlayerViewFactory(),
            withId: PlatformViewKind.ivsPlayerView.rawValue
        )
    }
}
