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
    private let ivsPlayerLayer: IVSPlayerLayer
    private let ivsPlayer: IVSPlayer

    init(
        ivsPlayer: IVSPlayer
    ) {
        self.ivsPlayer = ivsPlayer
        ivsPlayerLayer = IVSPlayerLayer(player: ivsPlayer)
        super.init(frame: .zero)
        // resizeAspectFillを設定すると、映像が流れなくなる
        ivsPlayerLayer.videoGravity = .resizeAspectFill

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
