import Foundation
import SwiftUI

extension DashboardView.DashboardViewModel {
    
    public func setAQIValueColor(value: Int, aqiLevels: AQILevels, aqiValueColor: inout Color) {
        switch value {
        case aqiLevels.good:
            aqiValueColor = .green
        case aqiLevels.fair:
            aqiValueColor = .yellow
        case aqiLevels.moderate:
            aqiValueColor = .orange
        case aqiLevels.poor:
            aqiValueColor = .red
        case aqiLevels.unhealthy:
            aqiValueColor = .purple
        default:
            aqiValueColor = .gray
        }
    }
    
    func updateAqiColor(value: Int) {
        self.setAQIValueColor(value: value, aqiLevels: AQILevels(), aqiValueColor: &aqiValueColor)
    }
}

