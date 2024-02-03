//
//  RequesterToNativeImpl.swift
//  integration_test
//
//  Created by Yugo Sugiyama on 2024/02/02.
//


import Foundation
import AVFoundation
import Flutter
import AmazonIVSPlayer

final class RequesterToNativeImpl: NSObject {
    private let player: IVSPlayer

    init(player: IVSPlayer) {
        self.player = player
    }

}

extension RequesterToNativeImpl: IvsPlayerRequesterToNative {
    func load(urlString: String) throws {
        player.load(URL(string: urlString))
    }
    
    func play() throws {
        player.play()
    }
    
    func pause() throws {
        player.pause()
    }

    func clean() throws {
        player.delegate = nil
    }
}

