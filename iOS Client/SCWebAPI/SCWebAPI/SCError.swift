//
//  SCError.swift
//  SCError
//
//  Created by Gellert Li on 8/8/21.
//

import Foundation

/// XHR Errors
public enum SCServiceError: Error {
    case noInternetConnection
    case custom(Any)
    case unauthorized
    case other
}
