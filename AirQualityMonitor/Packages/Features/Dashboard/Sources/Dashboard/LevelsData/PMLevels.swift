import Foundation

public struct PM25Level: PMGasLevels {
    public let good: ClosedRange<Double> = 0.01...15.0
    public let fair: ClosedRange<Double> = 15.1...35.0
    public let moderate: ClosedRange<Double> = 35.1...55
    public let poor: ClosedRange<Double> = 55.1...75.0
    public let unhealthy: ClosedRange<Double> = 75.1...100.0
}

public struct PM10Level: PMGasLevels {
    public let good: ClosedRange<Double> = 0.01...50.0
    public let fair: ClosedRange<Double> = 50.1...100.0
    public let moderate: ClosedRange<Double> = 100.1...150
    public let poor: ClosedRange<Double> = 150.1...200.0
    public let unhealthy: ClosedRange<Double> = 201.1...300.0
}
