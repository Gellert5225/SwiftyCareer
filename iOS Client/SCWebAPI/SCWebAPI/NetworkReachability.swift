//
//  NetworkReachability.swift
//  NetworkReachability
//
//  Created by Gellert Li on 8/8/21.
//

import Foundation
import Network
import SystemConfiguration

/// An observer to monitor network availability
public protocol NetworkReachabilityObserver: AnyObject {
    /// Protocol handler to handle the change of network availability
    func statusDidChange(status: NWPath.Status)
}


/// Monitor network availability and activity
final public class NetworkReachability {
    private struct NetworkReachabilityObservation {
        weak var observer: NetworkReachabilityObserver?
    }
    
    private var monitor = NWPathMonitor()
    private var observations = [ObjectIdentifier: NetworkReachabilityObservation]()
    private static let _sharedInstance = NetworkReachability()
    
    /// The current status of the network
    ///
    /// It returns the ``NWPath.Status`` enum
    public var currentStatus: NWPath.Status {
        get {
            return monitor.currentPath.status
        }
    }
    
    /// A getter function to get the shared instance of this class
    /// - Returns: A shared instance of ``NetworkReachability``
    public class func sharedInstance() -> NetworkReachability {
        return _sharedInstance
    }
    
    private init() {
        monitor.pathUpdateHandler = { [unowned self] path in
            for (id, observations) in self.observations {
                //If any observer is nil, remove it from the list of observers
                guard let observer = observations.observer else {
                    self.observations.removeValue(forKey: id)
                    continue
                }

                DispatchQueue.main.async(execute: {
                    observer.statusDidChange(status: path.status)
                })
            }
        }
        monitor.start(queue: DispatchQueue.global(qos: .background))
    }
    
    public func addObserver(observer: NetworkReachabilityObserver) {
        let id = ObjectIdentifier(observer)
        observations[id] = NetworkReachabilityObservation(observer: observer)
    }
    
    public func removeObserver(observer: NetworkReachabilityObserver) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
    
    public class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1, { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            })
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        
        return isNetworkReachable(with: flags)
    }
    
    private class func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectedAutometicaly = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectedWithoutUserInteraction = canConnectedAutometicaly && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectedWithoutUserInteraction)
    }
}
