//
//  IvsPlayerDelegate.swift
//  ivs_player_plugin
//
//  Created by Yugo Sugiyama on 2024/02/08.
//

import Foundation
import AmazonIVSPlayer

final class IvsPlayerDelegate: NSObject, IVSPlayer.Delegate {
    private let id: String
    private let requester: IvsPlayerRequesterToFlutter

    init(
        id: String,
        requester: IvsPlayerRequesterToFlutter
    ) {
        self.id = id
        self.requester = requester
        super.init()
    }

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
