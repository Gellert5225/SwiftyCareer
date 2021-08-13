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


extension SCServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString("Can't connect to internet", comment: "ha")
        case .custom(let err):
            if let error = err as? JSON {
                return NSLocalizedString("\(error["error"]!)", comment: "ha")
            }
            return NSLocalizedString("\(err)", comment: "ha")
        case .unauthorized:
            return NSLocalizedString("Unauthorized", comment: "ha")
        case .other:
            return NSLocalizedString("Unkown Error", comment: "ha")
        }
    }
}
