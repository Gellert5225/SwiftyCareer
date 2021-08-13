//
//  URLRequest+.swift
//  URLRequest+
//
//  Created by Gellert Li on 8/12/21.
//

import Foundation

internal extension URL {
    init(baseUrl: String, resource: SCResource) {
        var components = URLComponents(string: baseUrl)!
        let resourceComponents = URLComponents(string: resource.path.absolutePath)!
        
        components.path = Path(components.path).appending(path: Path(resourceComponents.path)).absolutePath
        components.queryItems = resourceComponents.queryItems
        
        switch resource.method {
            case .GET, .DELETE:
                var queryItems = components.queryItems ?? []
                queryItems.append(contentsOf: resource.params.map {
                    URLQueryItem(name: $0.key, value: String(describing: $0.value))
                })
                components.queryItems = queryItems
            default:
                break
        }
        
        self = components.url!
    }
}

internal extension URLRequest {
    init(baseUrl: String, resource: SCResource) {
        let url = URL(baseUrl: baseUrl, resource: resource)
        self.init(url: url)
        httpMethod = resource.method.rawValue
        resource.headers.forEach{
            setValue($0.value, forHTTPHeaderField: $0.key)
        }
        switch resource.method {
            case .POST, .PUT:
            httpBody = try! JSONSerialization.data(withJSONObject: resource.params, options: .prettyPrinted)
            default:
                break
        }
    }
}
