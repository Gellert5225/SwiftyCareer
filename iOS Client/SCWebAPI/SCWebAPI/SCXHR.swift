//
//  SCXHR.swift
//  SCXHR
//
//  Created by Gellert Li on 8/8/21.
//

import Foundation

/// Handles all HTTP requests
open class SCXHR {
    private var serverURL = SCWebAPI.config.serverURL
    
    /// Common query params or bodies for all requests
    public var commonParams: JSON = [:]
    
    /// Default initializer
    public init() {}
    
    /// HTTP request
    /// - Parameters:
    ///   - resource: HTTP request resources
    ///   - completion: Callback to handle ``SCResponse``
    public func request(resource: SCResource, completion: @escaping (SCResponse) ->()) {
        if !NetworkReachability.isConnectedToNetwork() {
            completion(SCResponse(response: nil, error: .custom(5000, "No Internet Connection"), cookie: nil))
            return
        }
        
        var newResouce = resource
        newResouce.params = newResouce.params.merging(commonParams) { spec, common in
            return spec
        }
        let jar = HTTPCookieStorage.shared
        let cookieHeaderField = ["Set-Cookie": "user_jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMGZiMTA0MmU5OWUwNjY3MjgyNWU0ZSIsImlhdCI6MTYyODc2MjM0MywiZXhwIjoxNjI4NzYyMzczfQ.pTiZ-7S9Su3pqOJ0W_kVAC3JH9Pvzwpa2c4Edx7WXoY"] 
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: cookieHeaderField, for: URL(string: serverURL + resource.path.absolutePath)!)
        jar.setCookies(cookies, for: URL(string: serverURL + resource.path.absolutePath), mainDocumentURL: URL(string: serverURL + resource.path.absolutePath))
        let request = URLRequest(baseUrl: serverURL, resource: newResouce)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, _ in
            // Parsing incoming data
            guard let response = response as? HTTPURLResponse else {
                completion(SCResponse(response: nil, error: .custom(500, "Internal Server Error"), cookie: nil))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] {
                    let cookieStorage = HTTPCookieStorage.shared
                    let cookies = cookieStorage.cookies(for: request.url!) ?? []
                    
                    if (200..<300) ~= response.statusCode {
                        completion(SCResponse(response: json, error: nil, cookie: cookies))
                    } else if response.statusCode == 401 {
                        completion(SCResponse(response: json, error: .other, cookie: cookies))
                    } else {
                        completion(SCResponse(response: json, error: .custom(json["code"] ?? 0, json["error"] ?? "Unknonw Error"), cookie: cookies))
                    }
                } else {
                    completion(SCResponse(response: nil, error: .other, cookie: nil))
                }
            } catch _ {
                completion(SCResponse(response: nil, error: .custom(500, "Internal Server Error"), cookie: nil))
            }
        }
        
        task.resume()
    }
}
