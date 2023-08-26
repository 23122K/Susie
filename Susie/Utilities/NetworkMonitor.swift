//
//  NetworkMonitor.swift
//  Susie
//
//  Created by Patryk Maciąg on 26/08/2023.
//

import Foundation

class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor.monitor.queue")
    weak var delegate: NetworkStatusDelegate?
    
    func start() { monitor.start(queue: queue) }
    func stop() { monitor.cancel() }
    
    init() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.delegate?.networkStatusDidChange(to: .connected)
            } else {
                self.delegate?.networkStatusDidChange(to: .disconnected)
            }
        }
    }
}
