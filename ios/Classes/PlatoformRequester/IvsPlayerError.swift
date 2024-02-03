//
//  IvsPlayerError.swift
//  integration_test
//
//  Created by Yugo Sugiyama on 2024/02/02.
//

import Foundation
import Flutter

extension FlutterError: Error {}

enum IvsPlayerError: Error {
    case invalidResponse
    case customError(text: String)

    var asFlutterError: FlutterError {
        switch self {
        case .invalidResponse:
            return FlutterError(code: "", message: nil, details: nil)
        case .customError(let text):
            return FlutterError(code: "", message: text, details: nil)
        }
    }
}


