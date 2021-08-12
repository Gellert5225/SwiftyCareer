//
//  SCResource.swift
//  SCResource
//
//  Created by Gellert Li on 8/11/21.
//

import Foundation

/// The resource field of XHR, including the request path, HTTP Method, headers and params
public struct SCResource {
    let path: Path
    let method: HTTPMethod
    
    var headers: HTTPHeaders
    var params: JSON
    
    /// Initialize the XHR
    /// - Parameters:
    ///   - path: The request path
    ///   - method: ``HTTPMethod``
    ///   - params: Query params or request body in ``JSON`` format
    ///   - headers: ``HTTPHeaders``
    ///
    /// When the request is GET or DELETE, the `params`field represents the query params.
    ///
    /// When the request is POST or PUT, the `params` field represents the request body.
    public init(path: String, method: HTTPMethod = .GET, params: JSON = [:], headers: HTTPHeaders = [:]) {
        
        var newHeaders = headers
        newHeaders["Accept"] = "application/json"
        newHeaders["Content-Type"] = "application/json"
        
        self.path = Path(path)
        self.method = method
        self.params = params
        self.headers = headers
    }
}
