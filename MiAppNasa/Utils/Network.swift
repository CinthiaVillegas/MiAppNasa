//
//  Network.swift
//  MiAppNasa
//
//  Created by Cinthia Villegas on 23/03/26.
//

import Foundation
import Network

class Network {
    static let shared = Network()
    let monitor = NWPathMonitor()
    var isOnline: Bool = true
    let queueNetwork = DispatchQueue.global(qos: .background)
    
    func startObserver() {
        monitor.pathUpdateHandler = { path in
            self.isOnline = (path.status == .satisfied)
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .networkStatusChanged, object: nil)
            }
        }
        monitor.start(queue: queueNetwork)
    }
}
extension Notification.Name {
    static let networkStatusChanged = Notification.Name("networkStatusChanged")
}

