import Authentication
import Dashboard
import Firebase
import Models
import Networking
import SessionManager
import Settings
import SwiftUI
import UIComponents

@main
struct AirQualityMonitorApp: App {
    
    init() {
        FirebaseApp.configure()
        FontLoader.registerFonts()
        NetworkManager.shared.startMonitoring()
    }
    
    @StateObject var settingsViewModel = SettingsView.SettingsViewModel()
    @StateObject var sessionManager = SessionManager()
    @StateObject var signUp = SignUp()
    @StateObject var passwordResetViewModel = VerifyResetCredentialsViewModel()
    @StateObject var networkManager = NetworkManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                settingsViewModel: settingsViewModel,
                sessionManager: sessionManager,
                signUp: signUp,
                verifyResetCredentialsViewModel: passwordResetViewModel,
                dashboardViewModel: DashboardView.DashboardViewModel(settingsViewModel: settingsViewModel),
                dataLoader: DataLoader()
            )
        }
    }
}
