//
//  NetworkReachability.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//
import Network

class NetworkReachability {
    // Single Instance of this NetworkReachability
    static let shared = NetworkReachability()
    
    // Network Monitor
    private let monitor = NWPathMonitor()
    
    // Bool Variable to Check
    private(set) var isReachable: Bool = false
    
    // Queue for background operation
    private let bgQueue = DispatchQueue.global(qos: .background)
    
    /// Initialiser & start monitoring
    private init() {
        monitor.pathUpdateHandler = { path in
            self.isReachable = path.status == .satisfied
        }
        monitor.start(queue: bgQueue)
    }
    
    /// Stop Monitoring
    func stopMonitoring() {
        monitor.cancel()
    }
}
