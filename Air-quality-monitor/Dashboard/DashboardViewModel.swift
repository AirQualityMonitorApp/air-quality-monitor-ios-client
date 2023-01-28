import Foundation
import SwiftUI

public extension DashboardView {
    @MainActor class DashboardViewModel: ObservableObject {
        
        @Published public var co2: Double = 0
        @Published public var temp: Double = 0
        @Published public var humidity: Double = 0
        @Published public var voc: Double = 0
        @Published public var pm: Double = 0
        @Published public var aqiScore: Int = 0
        
        @Published public var tempColor: Color = .white
        @Published public var humidityColor: Color = .white
        @Published public var co2Color: Color = .white
        @Published public var vocColor: Color = .white
        @Published public var pmColor: Color = .white
        @Published public var aqiValueColor: Color = .white
        
        public var celsiusFahrenheitTemp: Double {
            get {
                if settingsViewModel.isFahrenheit {
                    return ((9/5 * self.temp) + 32).truncate(positions: 2)
                }
                return self.temp
            }
        }
        
        public let settingsViewModel: SettingsView.SettingsViewModel
        
        init(settingsViewModel: SettingsView.SettingsViewModel) {
            self.settingsViewModel = settingsViewModel
        }
    }
}

extension Double {
    func truncate(positions : Int)-> Double {
        return Double(floor(pow(10.0, Double(positions)) * self)/pow(10.0, Double(positions)))
    }
}
