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

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        guard let params = args as? Dictionary<String, Any>,
              let id = params["id"] as? String else {
            fatalError("`args` paramter must be `Int`!")
        }

        if let platformView = IvsPlayerFlutterPlugin.ivsPlayerViews[id] {
            return platformView
        } else {
            fatalError("id is invalid") 
        }
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
