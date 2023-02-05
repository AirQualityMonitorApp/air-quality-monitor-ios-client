import Foundation

public protocol TempHumidityLevels {
    var good: ClosedRange<Double> { get }
    var fairLow: ClosedRange<Double> { get }
    var fairHigh: ClosedRange<Double> { get }
    var moderateLow: ClosedRange<Double> { get }
    var moderateHigh: ClosedRange<Double> { get }
    var poorLow: ClosedRange<Double> { get }
    var poorHigh: ClosedRange<Double> { get }
    var unhealthyLow: ClosedRange<Double> { get }
    var unhealthyHigh: ClosedRange<Double> { get }
}
