import Foundation
import SwiftUI

extension DashboardView.DashboardViewModel {
    private func setTempHumidityCardColor(value: Double, level: TempHumidityLevels, color: inout Color) {
        switch value {
        case level.good:
            color = .green
        case level.fairLow:
            color = .yellow
        case level.fairHigh:
            color = .yellow
        case level.moderateLow:
            color = .orange
        case level.moderateHigh:
            color = .orange
        case level.poorLow:
            color = .blue
        case level.poorHigh:
            color = .red
        case level.unhealthyLow:
            color = .blue
        case level.unhealthyHigh:
            color = .red
        default:
            color = .white
        }
    }

    public func updateTemperatureCardsColor (value: Double) {
        setTempHumidityCardColor(value: value, level: TemperatureLevel(), color: &tempColor)
    }
    
    public func updateHumidityCardsColor (value: Double) {
        setTempHumidityCardColor(value: value, level: HumidityLevel(), color: &humidityColor)
    }
}

