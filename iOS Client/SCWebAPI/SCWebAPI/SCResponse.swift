//
//  SCResponse.swift
//  SCResponse
//
//  Created by Gellert Li on 8/11/21.
//

import Foundation

/// Response of an HTTP request
public struct SCResponse {
    
    /// The response body
    public var res: JSON?
    
    /// The response error
    public var err: SCServiceError?
    
    /// The response cookie
    public var cookie: [HTTPCookie]?
    
    init(response: JSON?, error: SCServiceError?, cookie: [HTTPCookie]?) {
        self.res = response
        self.err = error
        self.cookie = cookie
    }
}

