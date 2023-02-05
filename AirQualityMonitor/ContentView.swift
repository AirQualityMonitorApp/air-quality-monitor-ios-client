import Authentication
import Dashboard
import Firebase
import SessionManager
import Settings
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var settingsViewModel: SettingsView.SettingsViewModel
    @ObservedObject var sessionManager: SessionManager
    @ObservedObject var signUp: SignUp
    @ObservedObject var verifyResetCredentialsViewModel: VerifyResetCredentialsViewModel
    @StateObject var dashboardViewModel: DashboardView.DashboardViewModel
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            VStack {
                switch sessionManager.appState {
                case .authorized:
                    ViewRouter(
                        settingsViewModel: settingsViewModel,
                        sessionManager: sessionManager,
                        dashboardInteractor: DashboardInteractor(viewModel: dashboardViewModel, settingsViewModel: settingsViewModel, sessionManager: sessionManager),
                        size: geometry.size
                    )
                case .unauthorized:
                    SignInView(sessionManager: sessionManager, size: geometry.size)
                        .onAppear {
                            Task {
                                await sessionManager.checkSessionOnStartup()
                            }
                        }
                case .signinUp:
                    SignUpView(signUp: signUp, sessionManager: sessionManager, size: geometry.size)
                case .verifyEmail:
                    VerifyEmailView(viewModel: verifyResetCredentialsViewModel, sessionManager: sessionManager, size: geometry.size)
                case .passwordReset:
                    PasswordResetView(viewModel: verifyResetCredentialsViewModel, sessionManager: sessionManager, size: geometry.size)
                case .signingIn:
                    LoadingView(width: geometry.size.width, height: geometry.size.height)
                case .loading: ProgressView()
                case .error: EmptyView()
                }
            }.onAppear{
                getUser()
            }
        }
        .background(
            Color.white
        )
        .edgesIgnoringSafeArea(.all)
        
    }
}

extension ContentView {
    func getUser() {
        sessionManager.listen()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(settingsViewModel: SettingsView.SettingsViewModel(), sessionManager: SessionManager(), signUp: SignUp(), verifyResetCredentialsViewModel: VerifyResetCredentialsViewModel(), dashboardViewModel: DashboardView.DashboardViewModel(settingsViewModel: SettingsView.SettingsViewModel()))
    }
}
#endif
