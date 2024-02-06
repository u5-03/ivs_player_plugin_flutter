//
//  IvsPlayerView.swift
//  integration_test
//
//  Created by Yugo Sugiyama on 2024/02/02.
//

import Foundation
import Flutter
import AmazonIVSPlayer

final class IvsPlayerPlatformView: UIView, FlutterPlatformView {
    private let id: String
    private let requester: IvsPlayerRequesterToFlutter
    private let ivsPlayerLayer: IVSPlayerLayer
    private let ivsPlayer: IVSPlayer

    init(
        id: String,
        requester: IvsPlayerRequesterToFlutter,
        ivsPlayer: IVSPlayer
    ) {
        self.id = id
        self.requester = requester
        self.ivsPlayer = ivsPlayer
        ivsPlayerLayer = IVSPlayerLayer(player: ivsPlayer)
        super.init(frame: .zero)
        ivsPlayer.delegate = self
        // resizeAspectFillを設定すると、映像が流れなくなる
//        ivsPlayerLayer.videoGravity = .resizeAspectFill

        layer.addSublayer(ivsPlayerLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        ivsPlayerLayer.bounds = bounds
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)

        ivsPlayerLayer.frame = bounds
    }

    func view() -> UIView {
        return self
    }
}

extension IvsPlayerPlatformView: IVSPlayer.Delegate {
    func player(_ player: IVSPlayer, didChangeState state: IVSPlayer.State) {
        let playerState: PlayerState
        switch state {
        case .ready: playerState = .ready
        case .buffering: playerState = .buffering
        case .playing: playerState = .playing
        case .idle: playerState = .idle
        case .ended: playerState = .ended
        @unknown default: playerState = .idle
        }
        requester.didChangeState(id: id, state: playerState, completion: { _ in })
    }

    func player(_ player: IVSPlayer, didFailWithError error: Error) {
        requester.didChangeState(id: id, state: .error, completion: { _ in  })
    }

    func player(_ player: IVSPlayer, didChangeDuration duration: CMTime) {
        requester.didChangeDuration(id: id, duration: duration.seconds, completion: { _ in })
    }
}
