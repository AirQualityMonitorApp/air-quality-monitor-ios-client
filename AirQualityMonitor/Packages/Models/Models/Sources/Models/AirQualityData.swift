import Foundation

public struct AirQuality: Codable, Equatable, Hashable, Identifiable {
    
    public var id: String { UUID().uuidString }
    public let aqScore: Int?
    public let tempCelsius: Double?
    public let humidity: Double?
    public let co2: Double?
    public let vocIndex: Double?
    public let tvoc: Double?
    public let pm25: Double?
    public let pm10: Double?
    public let timestamp: String?
    
    init(aqScore: Int? = nil, tempCelsius: Double? = nil, humidity: Double? = nil, co2: Double? = nil, vocIndex: Double? = nil, tvoc: Double? = nil, pm25: Double? = nil, pm10: Double? = nil, timestamp: String? = nil) {
        self.aqScore = aqScore
        self.tempCelsius = tempCelsius
        self.humidity = humidity
        self.co2 = co2
        self.vocIndex = vocIndex
        self.tvoc = tvoc
        self.pm25 = pm25
        self.pm10 = pm10
        self.timestamp = timestamp
    }
}
