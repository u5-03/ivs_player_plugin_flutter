//
//  IvsPlayerView.swift
//  integration_test
//
//  Created by Yugo Sugiyama on 2024/02/02.
//

import Foundation
import Flutter
import AmazonIVSPlayer

final class IvsPlayerWrapperView: UIView, FlutterPlatformView {
    private let requester: IvsPlayerRequesterToFlutter
    private let ivsPlayerLayer: IVSPlayerLayer

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        requester: IvsPlayerRequesterToFlutter,
        ivsPlayer: IVSPlayer
    ) {
        self.requester = requester
        ivsPlayerLayer = IVSPlayerLayer(player: ivsPlayer)
        super.init(frame: frame)
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

extension IvsPlayerWrapperView: IVSPlayer.Delegate {
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
        requester.didChangeState(state: playerState, completion: { _ in })
    }

    func player(_ player: IVSPlayer, didFailWithError error: Error) {
        requester.didChangeState(state: .error, completion: { _ in  })
    }

    func player(_ player: IVSPlayer, didChangeDuration duration: CMTime) {
        requester.didChangeDuration(duration: duration.seconds, completion: { _ in })
    }
}
