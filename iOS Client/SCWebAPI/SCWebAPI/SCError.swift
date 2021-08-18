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
    public var errorCode: Int? {
        switch self {
        case .noInternetConnection:
            return 001
        case .custom(let err):
            if let error = err as? JSON {
                return error["status"] as? Int
            }
            return 002
        case .unauthorized:
            return 002
        case .other:
            return 003
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString("No Internet Connection", comment: "ha")
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
