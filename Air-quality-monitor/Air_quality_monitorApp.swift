import Firebase
import Models
import Networking
import SwiftUI
import UIComponents

@main
struct Air_quality_monitorApp: App {
    
    init() {
        FirebaseApp.configure()
        FontLoader.registerFonts()
    }
    
    @StateObject var settingsViewModel = SettingsView.SettingsViewModel()
    @StateObject var sessionManager = SessionManager()
    @StateObject var signUp = SignUp()
    @StateObject var passwordResetViewModel = VerifyResetCredentialsViewModel()
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                settingsViewModel: settingsViewModel,
                sessionManager: sessionManager,
                signUp: signUp,
                verifyResetCredentialsViewModel: passwordResetViewModel, dashboardViewModel: DashboardView.DashboardViewModel(settingsViewModel: settingsViewModel)
            )
        }
    }
}
