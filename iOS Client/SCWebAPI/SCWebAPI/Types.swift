//
//  Types.swift
//  Types
//
//  Created by Gellert Li on 8/8/21.
//

import Foundation

/// A typealias to represent JSON data
public typealias JSON = [String: Any]

/// A typealias to represent HTTP Header fields
public typealias HTTPHeaders = [String: String]

/// HTTP Verbs
public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}
