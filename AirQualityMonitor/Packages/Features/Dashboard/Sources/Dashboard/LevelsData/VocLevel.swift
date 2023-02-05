import Foundation

public struct VocLevel: PmGasLevels {
    public let good: ClosedRange<Double> = 0.01...100.0
    public let fair: ClosedRange<Double> = 100.1...200.0
    public let moderate: ClosedRange<Double> = 200.1...300.0
    public let poor: ClosedRange<Double> = 300.1...400
    public let unhealthy: ClosedRange<Double> = 400.1...500.0
}
