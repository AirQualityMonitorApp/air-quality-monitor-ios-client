import Foundation
import Network

public final class NetworkManager: ObservableObject {
    public enum NetworkState {
        case connected
        case notConnected
        case unknown
    }
    
    public enum ConnectionType {
        case wifiNetwork
        case mobileNetwork
        case unknown
    }
    
    public static let shared = NetworkManager()
    private let monitor = NWPathMonitor()
    
    private var _networkState: NetworkState = .unknown
    
    public var networkState: NetworkState {
        get {
            return _networkState
        }
        set {
            _networkState = newValue
        }
    }
    
    private var conncectionType: ConnectionType = .unknown
    
    public init() {}
    
    public func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.networkState = .connected
            } else {
                self.networkState = .notConnected
            }
            
            if path.usesInterfaceType(.wifi) {
                self.conncectionType = .wifiNetwork
            } else if path.usesInterfaceType(.cellular) {
                self.conncectionType = .mobileNetwork
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
