import Foundation

public struct VocLevel: PMGasLevels {
    public let good: ClosedRange<Double> = 0.01...100.0
    public let fair: ClosedRange<Double> = 100.1...200.0
    public let moderate: ClosedRange<Double> = 200.1...300.0
    public let poor: ClosedRange<Double> = 300.1...400
    public let unhealthy: ClosedRange<Double> = 400.1...500.0
}

public struct TvocLevel: PMGasLevels {
    public let good: ClosedRange<Double> = 0.01...300.0
    public let fair: ClosedRange<Double> = 300.1...500.0
    public let moderate: ClosedRange<Double> = 500.1...1000.0
    public let poor: ClosedRange<Double> = 1000.1...3000
    public let unhealthy: ClosedRange<Double> = 3000.1...8000.0
}
