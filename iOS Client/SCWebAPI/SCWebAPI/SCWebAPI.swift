//
//  SCWebClient.swift
//  SCWebClient
//
//  Created by Gellert Li on 8/8/21.
//

import Foundation

/// Configuration for the SwiftyCareer server
public struct SCWebAPIConfiguration {
    
    /// The server URL to connect to SwiftyCareer server
    internal var serverURL: String
    
    /// Create a SwiftyCareer server configuration
    /// - Parameters:
    ///   - serverURL: The server URL to connect to SwiftyCareer server
    ///   - port: The port number of SwiftyCareer server
    public init(serverURL: String) {
        self.serverURL = serverURL
    }
}


/// Provides a static function to handle the global configuration
public struct SCWebAPI {
    /// Configuration for the SwiftyCareer server
    static var config: SCWebAPIConfiguration!
    
    /// Configure and initialize the SCWebAPI Client.
    ///
    /// You must use it at the start of your app, typically inside the function
    ///
    /// `application(_: didFinishLaunchingWithOptions:)` in `AppDelegate.swift`.
    /// ```swift
    /// let config = SCWebAPIConfiguration(serverURL: URL(string: "192.168.1.16")!, port: "1336")
    /// SCWebAPI.Initialize(with: config)
    /// ```
    ///
    /// - Parameter config: Configuration for the SwiftyCareer server
    static public func Initialize(with config: SCWebAPIConfiguration) {
        Self.config = config
    }
}
