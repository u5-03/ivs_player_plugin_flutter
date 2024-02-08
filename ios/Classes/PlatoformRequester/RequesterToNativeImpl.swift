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
    private let registrar: FlutterPluginRegistrar
    private let requester: IvsPlayerRequesterToFlutter

    init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
        requester = IvsPlayerRequesterToFlutter(binaryMessenger: registrar.messenger())
    }
}

extension RequesterToNativeImpl: IvsPlayerRequesterToNative {
    func create() throws -> CreateResponse {
        let id = UUID().uuidString
        let ivsPlayer = IVSPlayer()

        let delegate = IvsPlayerDelegate(id: id, requester: requester)
        ivsPlayer.delegate = delegate
        let response = CreateResponse(id: id)

        IvsPlayerFlutterPlugin.ivsPlayerDelegates[id] = delegate
        IvsPlayerFlutterPlugin.ivsPlayers[id] = ivsPlayer

        return response
    }

    func removeExcept(id: String) throws {
        IvsPlayerFlutterPlugin.ivsPlayers = IvsPlayerFlutterPlugin.ivsPlayers.filter({ $0.key == id })
        IvsPlayerFlutterPlugin.ivsPlayerViews = IvsPlayerFlutterPlugin.ivsPlayerViews.filter({ $0.key == id })
    }

    func resetAll() throws {
        IvsPlayerFlutterPlugin.ivsPlayers.removeAll()
        IvsPlayerFlutterPlugin.ivsPlayerViews.removeAll()
    }

    func load(id: String, urlString: String) throws {
        IvsPlayerFlutterPlugin.ivsPlayers[id]?.load(URL(string: urlString))
    }

    func play(id: String) throws {
        IvsPlayerFlutterPlugin.ivsPlayers[id]?.play()
    }

    func pause(id: String) throws {
        IvsPlayerFlutterPlugin.ivsPlayers[id]?.pause()
    }

    func clean(id: String) throws {
        IvsPlayerFlutterPlugin.ivsPlayers[id]?.delegate = nil
        IvsPlayerFlutterPlugin.ivsPlayerDelegates.removeValue(forKey: id)
        IvsPlayerFlutterPlugin.ivsPlayers.removeValue(forKey: id)
        IvsPlayerFlutterPlugin.ivsPlayerViews.removeValue(forKey: id)
    }
}
