import Foundation

public struct PmLevel: PmGasLevels {
    public let good: ClosedRange<Double> = 0.01...15.0
    public let fair: ClosedRange<Double> = 15.1...35.0
    public let moderate: ClosedRange<Double> = 35.1...55
    public let poor: ClosedRange<Double> = 55.1...75.0
    public let unhealthy: ClosedRange<Double> = 75.1...100.0
}
