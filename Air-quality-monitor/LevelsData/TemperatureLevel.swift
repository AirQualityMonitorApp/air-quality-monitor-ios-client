import Foundation

public struct TemperatureLevel: TempHumidityLevels {
    public let good: ClosedRange<Double> = 18.0...25.0
    public let fairLow: ClosedRange<Double> = 17.0...17.9
    public let fairHigh: ClosedRange<Double> = 25.1...25.9
    public let moderateLow: ClosedRange<Double> = 11.0...16.9
    public let moderateHigh: ClosedRange<Double> = 26.0...31.9
    public let poorLow: ClosedRange<Double> = 9.1...10.9
    public let poorHigh: ClosedRange<Double> = 32.0...33.9
    public let unhealthyLow: ClosedRange<Double> = -60.0...9.0
    public let unhealthyHigh: ClosedRange<Double> = 34.0...65.0
}
