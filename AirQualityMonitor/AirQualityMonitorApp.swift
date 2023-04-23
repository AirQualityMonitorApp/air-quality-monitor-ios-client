import Dashboard
import Models
import Networking
import Settings
import SwiftUI
import UIComponents

@main
struct AirQualityMonitorApp: App {
    init() {
        FontLoader.registerFonts()
        NetworkManager.shared.startMonitoring()
    }
    
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var dashboardViewModel = DashboardViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(settingsViewModel: settingsViewModel, dashboardViewModel: dashboardViewModel)
        }
    }
}
