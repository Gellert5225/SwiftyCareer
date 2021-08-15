//
//  SCXHR.swift
//  SCXHR
//
//  Created by Gellert Li on 8/8/21.
//

import Foundation

/// Handles all HTTP requests
open class SCXHR {
    private var serverURL = SCWebClient.config.serverURL
    
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
            completion(SCResponse(response: nil, error: .noInternetConnection, cookie: nil))
            return
        }
        
        var newResouce = resource
        newResouce.params = newResouce.params.merging(commonParams) { spec, common in
            return spec
        }
//        print("absolute path: \(resource.path.absolutePath)")
//        let jar = HTTPCookieStorage.shared
//        let cookieHeaderField = ["Set-Cookie": "user_jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMThlOWIzYTE1ODBiNDAyNGY0M2M1ZSIsImlhdCI6MTYyOTAyMjY0MywiZXhwIjoxNjI5MDIyNzAzfQ.qhqGq-jD7iheaF3lF0FfXgvYMSegkPHgLqiG-SVyILU"]
//        let cookies = HTTPCookie.cookies(withResponseHeaderFields: cookieHeaderField, for: URL(string: serverURL + resource.path.absolutePath)!)
//        jar.setCookies(cookies, for: URL(string: serverURL + resource.path.absolutePath), mainDocumentURL: URL(string: serverURL + resource.path.absolutePath))
        let request = URLRequest(baseUrl: serverURL, resource: newResouce)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Parsing incoming data
            // let base64String = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            //print(base64String)
            if let error = error {
                DispatchQueue.main.async {
                    completion(SCResponse(response: nil, error: .custom(["status": 500, "error": error.localizedDescription]), cookie: nil))
                }
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(SCResponse(response: nil, error: .custom(["status": 500, "error": "Internal Server Error"]), cookie: nil))
                }
                return
            }
            print("Status code: \(response.statusCode)")
            
            let SCXHRResponse: JSON?
            let json = try? JSONSerialization.jsonObject(with: data ?? Data(), options: .mutableContainers) as? JSON
            if (json != nil) { SCXHRResponse = json }
            else { SCXHRResponse = ["data": data!] }

            let cookieStorage = HTTPCookieStorage.shared
            let cookies = cookieStorage.cookies(for: request.url!) ?? []

            if (200..<300) ~= response.statusCode {
                DispatchQueue.main.async {
                    completion(SCResponse(response: SCXHRResponse, error: nil, cookie: cookies))
                }
            } else {
                DispatchQueue.main.async {
                    completion(SCResponse(response: SCXHRResponse, error: .custom(["status": response.statusCode, "error": json!["error"]!]), cookie: cookies))
                }
            }
        }
        
        task.resume()
    }
}
