import Foundation

public protocol PMGasLevels {
    var good: ClosedRange<Double> { get }
    var fair: ClosedRange<Double> { get }
    var moderate: ClosedRange<Double> { get }
    var poor: ClosedRange<Double> { get }
    var unhealthy: ClosedRange<Double> { get }
}
