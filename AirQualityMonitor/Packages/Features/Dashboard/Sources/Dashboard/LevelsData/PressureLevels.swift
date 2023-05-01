import Foundation

public struct PressureLevel {
    public let high: ClosedRange<Double>
    public let intermediate: ClosedRange<Double>
    public let low: ClosedRange<Double>
}
