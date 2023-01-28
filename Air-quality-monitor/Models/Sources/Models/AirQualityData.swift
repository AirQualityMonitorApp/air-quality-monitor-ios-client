import Foundation

public struct AirQuality: Codable, Equatable, Hashable, Identifiable {
    
    public var id: String { UUID().uuidString }
    public var AQScore: Int?
    public var temperature: Double?
    public var humidity: Double?
    public var co2: Double?
    public var tvoc: Double?
    public var pm: Double?
    public var timestamp: String
    
    init(AQS: Int, temperature: Double, humidity: Double, co2: Double, tvoc: Double, pm: Double, timestamp: String) {
        self.AQScore = AQS
        self.temperature = 0
        self.humidity = 0
        self.co2 = 0
        self.tvoc = 0
        self.pm = 0
        self.timestamp = timestamp
    }
}
