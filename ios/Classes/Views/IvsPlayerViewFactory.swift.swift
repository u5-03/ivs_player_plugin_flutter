//
//  IvsPlayerViewFactory.swift.swift
//  integration_test
//
//  Created by Yugo Sugiyama on 2024/02/02.
//

import Foundation
import Flutter
import AmazonIVSPlayer

final class IvsPlayerViewFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger
    private let player: IVSPlayer
    private let requester: IvsPlayerRequesterToFlutter

    init(messenger: FlutterBinaryMessenger, player: IVSPlayer, requester: IvsPlayerRequesterToFlutter) {
        self.messenger = messenger
        self.player = player
        self.requester = requester
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        let playerView =  IvsPlayerWrapperView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            requester: requester,
            ivsPlayer: player
        )
        return playerView
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
