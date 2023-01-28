import Foundation

public struct HumidityLevel: TempHumidityLevels {
    public let good = 40.0...50.0
    public let fairLow = 35.0...39.9
    public let fairHigh = 50.1...60.0
    public let moderateLow = 20.0...34.9
    public let moderateHigh = 60.1...65.0
    public let poorLow = 15.0...19.9
    public let poorHigh = 65.1...80.0
    public let unhealthyLow = 0.01...14.9
    public let unhealthyHigh = 80.1...100.0
}
