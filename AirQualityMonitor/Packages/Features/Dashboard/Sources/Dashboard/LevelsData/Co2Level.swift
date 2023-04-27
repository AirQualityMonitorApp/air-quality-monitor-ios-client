import Foundation

public struct Co2Level: PMGasLevels {
    public let good: ClosedRange<Double> = 0.01...600
    public let fair: ClosedRange<Double> = 601.0...1000
    public let moderate: ClosedRange<Double> = 1001.0...1500
    public let poor: ClosedRange<Double> = 1501.0...2500
    public let unhealthy: ClosedRange<Double> = 2500.0...10000.0
}
