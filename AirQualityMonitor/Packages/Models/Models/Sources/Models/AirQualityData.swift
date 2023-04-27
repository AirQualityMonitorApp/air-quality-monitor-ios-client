import Foundation

public struct AirQuality: Codable, Equatable, Hashable, Identifiable {
    
    public var id: String { UUID().uuidString }
    public var aqScore: Int?
    public var temperature: Double?
    public var humidity: Double?
    public var co2: Double?
    public var vocIndex: Double?
    public var pm25: Double?
    public var pm10: Double?
    public var timestamp: String?
    
    init(aqScore: Int? = nil, temperature: Double? = nil, humidity: Double? = nil, co2: Double? = nil, vocIndex: Double? = nil, pm25: Double? = nil, pm10: Double? = nil, timestamp: String? = nil) {
        self.aqScore = aqScore
        self.temperature = temperature
        self.humidity = humidity
        self.co2 = co2
        self.vocIndex = vocIndex
        self.pm25 = pm25
        self.pm10 = pm10
        self.timestamp = timestamp
    }
}
