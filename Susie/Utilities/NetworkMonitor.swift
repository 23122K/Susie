//
//  NetworkMonitor.swift
//  Susie
//
//  Created by Patryk Maciąg on 26/08/2023.
//

import Foundation
import Network

class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor.monitor.queue")
    private var currentNetworkStatus: NetworkStatus = .connected
    weak var delegate: NetworkStatusDelegate?
    
    //For unknown to me reasons monitor handler outputs same value several times
    func configure() {
        monitor.pathUpdateHandler = { [self] path in
            if path.status == .satisfied {
                if currentNetworkStatus == .disconnected {
                    delegate?.networkStatusDidChange(to: .connected)
                    currentNetworkStatus = .connected
                }
            } else {
                if currentNetworkStatus == .connected {
                    delegate?.networkStatusDidChange(to: .disconnected)
                    currentNetworkStatus = .disconnected
                }
            }
        }
    }
    
    func start() { monitor.start(queue: queue) }
    func stop() { monitor.cancel() }
    
    init() { configure() }
        
}
